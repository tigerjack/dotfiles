#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Remove text inside \deleted macro{}, flatten text inside \redacted{} macro.
Useful when submitting a camera ready.
"""
import argparse
import os
import re


def deleted(data: str):
    print("Deleting...")
    # Sample text
    # text = "This is some example text. \redacted{This text should be redacted.\bum{} Here is \textbf{more} text with a closing brace } Ciao."

    # Regex deleting all text inside \deleted macro, up to 3 level of nesting of {}
    # Check https://tex.stackexchange.com/a/167572/80949
    pattern = r"\\deleted\{(([^{}]*(\{(([^{}]*(\{[^{}]*\}[^{}]*)?)*)\}[^{}]*)?)*)\}"

    # Remove the deleted text using re.sub()
    deleted_removed = re.sub(pattern, "", data)
    return deleted_removed


def redacted(data: str):
    print("Redacting...")
    # Sample text
    # text = "In the meantime \\redacted{we all live in a} \\deleted{yellow}\\redacted{purple} submarine \\deleted{ \\textbf{Ciao} mondo \\textit{\\textbf{come va}}  here comes the sun. } na na nana. \\redacted{in the time \\textbf{that i was born} Freeeeezin'} ciao "

    pattern = r"\\redacted\{(([^{}]*(\{(([^{}]*(\{[^{}]*\}[^{}]*)?)*)\}[^{}]*)?)*)\}"

    last = 0
    data_red = []
    lenr = len("redacted")
    for match in re.finditer(pattern, data):
        print(match)
        data_app = data[last : match.start()]
        data_red.append(data_app)
        # data_red.append(" ")
        data_app = data[match.start() + lenr + 2 : match.end() - 1]
        data_red.append(data_app)
        # data_red.append(" ")
        last = match.end()

    data_app = data[last:]
    data_red.append(data_app)

    return "".join(data_red)


def elaborate(args):
    for filename in os.listdir(args.indir):
        print(f"Processing {filename}")
        if not filename.endswith('.tex'):
            print("...skip")
            continue
        filename_out: str = os.path.join(args.indir, args.outdir, filename)

        with open(os.path.join(args.indir, filename), encoding="utf-8", mode="r") as fin:
            maybe = True
            redacted_on = False
            deleted_on = False
            whole_file = fin.read()
            st = deleted(whole_file)
            st = redacted(st)
        with open(filename_out, encoding="utf-8", mode="w") as fout:
            fout.write(st)


def main():
    parser = argparse.ArgumentParser(
        prog="latex_redacted",
        description="Remove text inside \deleted, flatten text inside \redacted",
    )

    # parser.add_argument("filenames", nargs="+", help="One or more filenames")
    parser.add_argument("-i", "--indir",  help="Relative to original files")
    parser.add_argument("-o", "--outdir",  default="processed", help="Relative to source files")


    # Parse the command-line arguments
    args = parser.parse_args()

    os.makedirs(os.path.join(args.indir, args.outdir), exist_ok=True)

    elaborate(args)


if __name__ == "__main__":
    main()
