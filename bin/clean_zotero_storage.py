import sqlite3
import os
import shutil
from typing import Dict, Iterable
import argparse

_PROG_DESC = """Process directories from Zotero storage dir containing non-indexed files
"""


def _args_parsing():
    parser = argparse.ArgumentParser(
        description=_PROG_DESC,
        # epilog=_PROG_EPIL,
        formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument(
        "-zd",
        "--zotero-data",
        required=True,
        help="""Zotero data directory. You can check yours from Zotero:
Edit>Preferences>Advanced>Config Editor and then look for the value of
extensions.zotero.dataDir""")
    parser.add_argument(
        "--delete",
        action='store_true',
        help="""Delete directories. If not selected, directories are moved to the
directory provided with --outdir.""")
    parser.add_argument(
        '-od',
        '--outdir',
        help="""The output directory where the directories containing
non-indexed files will be moved. It makes sense only if --delete is
false. Default to --zotero-data/storage/bak""")
    return parser.parse_args()


def find_dups(storage_path: str):
    output: Dict[str, Dict] = {}
    # for dirpath, dirnames, filenames in os.walk(storage_path):
    for dir_path in next(os.walk(storage_path))[1]:
        for filename in filter(lambda x: x.endswith('pdf'),
                               os.listdir(storage_path + dir_path)):
            # output[dir_path] = output.get(dir_path, 0) + 1
            val = output.get(filename, {})
            count = val.get('count', 0) + 1
            paths = val.get('paths', list())
            paths.append(dir_path)
            val['count'] = count
            val['paths'] = paths
            output[filename] = val

    return filter(lambda x: x[1]['count'] > 1, output.items())


def query_db(db_path: str, iter_dic: Iterable):
    delete_list = []
    with sqlite3.connect(db_path) as conn:
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()
        for _, values in iter_dic:
            for dir_path in values['paths']:
                cursor.execute(
                    f"SELECT COUNT(*) FROM items WHERE key = '{dir_path}'")
                value_in_db = True if cursor.fetchone()[0] == 1 else 0
                if not value_in_db:
                    delete_list.append(dir_path)
    return delete_list


def process_duplicate_dirs(storage_path: str,
                           file_list: list,
                           delete=False,
                           outdir=None):
    if len(file_list) == 0:
        return
    if not delete:
        try:
            os.mkdir(outdir)
        except FileExistsError:
            show_must_go_on = input(
                "WARNING: bak dir already exist. Do you want to continue?[y/n]"
            )
            if show_must_go_on.lower() != 'y':
                print('bye')
                return
        for file_path in file_list:
            shutil.move(storage_path + file_path, outdir)
    else:
        for file_path in file_list:
            shutil.rmtree(storage_path + file_path)


def main():
    args = _args_parsing()
    zotero_main = args.zotero_data + "/"
    if not args.delete and args.outdir is None:
        args.outdir = zotero_main + 'bak/'
        print(
            f"Dirs containing non-indexed files will be put in {args.outdir}")
    zotero_storage = zotero_main + "storage/"
    zotero_db = zotero_main + "zotero.sqlite"
    iter_dic = find_dups(zotero_storage)
    delete_list = query_db(zotero_db, iter_dic)
    print(f"We found {len(delete_list)} directories not indexed by Zotero")
    process_duplicate_dirs(zotero_storage, delete_list, args.delete,
                           args.outdir)


if __name__ == '__main__':
    main()
