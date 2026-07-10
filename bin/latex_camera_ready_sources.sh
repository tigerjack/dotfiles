#!/usr/bin/env bash
# Prepare camera-ready LaTeX sources: copy assets, redact, flatten the
# document into a single file, and run package/bibliography checks.
#
# Every completed step is checkpointed in $CHECKPOINT_FILE, so a rerun
# skips the steps that already succeeded and resumes where the previous
# run stopped. Use --list to see step status, --from STEP to redo the
# pipeline from a given step, --only STEP for a single step, --fresh to
# forget all checkpoints.
set -o nounset   # Treat unset variables as an error
set -o errexit   # Abort on the first failing command
set -o pipefail  # A pipeline fails if any of its commands fail

readonly PROCESSED="98-processed"
readonly CAMERA_READY="99_CameraReady/submission"
readonly MAIN="main"
readonly STRIPPED="${MAIN}_stripped_squeezed"
readonly CHECKPOINT_FILE=".camera_ready_done"

# Pipeline in execution order; each entry has a matching step_<name> function
readonly STEPS=(
    copy_sources
    clean_aux
    redact
    fix_sources
    flatten
    check_packages
    build
    check_bibliography
    final_copy
)

step_copy_sources() {
    mkdir -p "$PROCESSED"/{tikz,algs,tabs}
    cp tikz/tikz_*.pdf "$PROCESSED/tikz"
    cp algs/alg*.tex "$PROCESSED/algs/"
    cp tabs/tab*.tex "$PROCESSED/tabs/"
    # cp -r ext_data/ "$PROCESSED"
    # cp -r figures/ "$PROCESSED"
    cp "$MAIN"*.bib "$PROCESSED"
}

step_clean_aux() {
    rm -f ./*.{aux,log,bbl,blg,synctex.gz} "$MAIN.pdf"
}

step_redact() {
    latex_redacted.py -i "$PWD" -o "$PROCESSED"
}

# Body in ( ) so the cd stays local to the step
step_fix_sources() (
    cd "$PROCESSED"
    echo "Removing BOM characters from source files"
    find . -type f -name "*.tex" -exec sed -i '1s/^\xEF\xBB\xBF//' {} +
    echo "Replacing custom input with plain input"
    find . -type f -name "*.tex" ! -name "cmds-main.tex" -exec sed -i \
        -e 's@\\includetab{\([^}]*\)}@\\input{\1}@g' \
        -e 's@\\includealg{\([^}]*\)}@\\input{\1}@g' {} +
)

step_flatten() (
    cd "$PROCESSED"
    echo "Removing comments, merging into single file, replacing standalone with graphics"
    latexpand --empty-comments "$MAIN.tex" \
        | sed -e '/^\s*%/d' \
              -e '/\\usepackage\[.*\]{standalone}/d' \
              -e 's|\\includestandalone|\\includegraphics|g' \
        | cat -s > "$STRIPPED.tex"
)

# Informational check: report problems but keep going
step_check_packages() (
    cd "$PROCESSED"
    LaTeXpkges.py --latex pdflatex --bibtex bibtex --parallel "$STRIPPED.tex" || true
)

step_build() (
    cd "$PROCESSED"
    latexmk -C
    latexmk -pdf -pdflatex \
        -use-make "$STRIPPED.tex"
)

# Informational checks: report problems but keep going
step_check_bibliography() (
    cd "$PROCESSED"
    echo "---------Printing unused entries"
    checkcites -a -b biber "$STRIPPED" || true
    echo "---------Checking bibliography"
    biblatex_check.py -b "${MAIN}_biblatex.bib" -a "$STRIPPED.aux" || true
)

step_final_copy() {
    mkdir -p "$CAMERA_READY/tikz"
    cp "$PROCESSED/$STRIPPED.tex" "$CAMERA_READY/$MAIN.tex"
    cp "$PROCESSED/$MAIN"*.bib "$CAMERA_READY/"
    cp "$PROCESSED"/tikz/*.pdf "$CAMERA_READY/tikz"
}

usage() {
    cat <<EOF
Usage: ${0##*/} [OPTION]
Build the camera-ready sources, checkpointing each completed step in
$CHECKPOINT_FILE so a rerun resumes after the last success.

  -l, --list         list the steps in order with their checkpoint status
  -f, --from STEP    redo the pipeline starting at STEP (clears its
                     checkpoint and every later one)
  -o, --only STEP    run a single step, ignoring checkpoints
      --fresh        forget all checkpoints and run everything
  -h, --help         show this help
EOF
}

is_done() {
    grep -qxF "$1" "$CHECKPOINT_FILE" 2>/dev/null
}

mark_done() {
    is_done "$1" || echo "$1" >> "$CHECKPOINT_FILE"
}

known_step() {
    local s
    for s in "${STEPS[@]}"; do
        [[ $s == "$1" ]] && return 0
    done
    echo "Unknown step: $1 (see --list)" >&2
    return 1
}

# Drop the checkpoints of $1 and every step after it
forget_from() {
    [[ -f $CHECKPOINT_FILE ]] || return 0
    local s keep=""
    for s in "${STEPS[@]}"; do
        [[ $s == "$1" ]] && break
        is_done "$s" && keep+="$s"$'\n'
    done
    printf '%s' "$keep" > "$CHECKPOINT_FILE"
}

list_steps() {
    local s
    for s in "${STEPS[@]}"; do
        if is_done "$s"; then
            printf '[done] %s\n' "$s"
        else
            printf '[todo] %s\n' "$s"
        fi
    done
}

run_step() {
    echo "=========> $1"
    "step_$1"
}

from_step=""
only_step=""
while (($#)); do
    case $1 in
        -l|--list)  list_steps; exit 0 ;;
        -f|--from)  from_step=${2:?--from needs a step name}; shift ;;
        -o|--only)  only_step=${2:?--only needs a step name}; shift ;;
        --fresh)    rm -f "$CHECKPOINT_FILE" ;;
        -h|--help)  usage; exit 0 ;;
        *)          echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
    esac
    shift
done

if [[ -n $only_step ]]; then
    known_step "$only_step"
    run_step "$only_step"
    mark_done "$only_step"
    exit 0
fi

if [[ -n $from_step ]]; then
    known_step "$from_step"
    forget_from "$from_step"
fi

for step in "${STEPS[@]}"; do
    if is_done "$step"; then
        echo "=========> $step (skipped: already done, redo with --from $step)"
        continue
    fi
    run_step "$step"
    mark_done "$step"
done

echo "All steps completed."
echo "A rerun now skips everything: use --fresh to redo all, --from STEP to redo part."
