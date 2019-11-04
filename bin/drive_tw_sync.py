#!/usr/bin/env python
import os
import socket
import subprocess
from tasklib import TaskWarrior
import logging
import argparse
#from tasklib import Task

logger = logging.getLogger(__name__)
hosts={'hp255g6', 'virtualarch'}

def _usage():
    parser = argparse.ArgumentParser(
        description="Interface to drive")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--push', action='store_true', help='The n of the code')
    group.add_argument('--pull', action='store_true', help='The n of the code')
    args = parser.parse_args()
    return args


def _get_drive_path():
    p = subprocess.Popen('xdg-user-dir PUBLICSHARE', shell=True, stdout=subprocess.PIPE)
    stdout, _ = p.communicate()
    drive_path = stdout.decode("utf-8").strip() + "/drive/"
    return drive_path

def _get_tasks(tw, host, push):
    if push:
        # Tags created by the host which have to be pushed
        return tw.tasks.pending().filter(project="drive").filter(tags__contains=[host+'_to_push'])
    else:
        # Tags pushed by others and not pulled by host
        return tw.tasks.pending().filter(project="drive").filter(tags__contains=['_pushed']).filter("-"+host+"_pulled").filter("-"+host+"_pushed")

def _compact_changes(tsks, excluded_paths={}):
    s = set()
    for t in tsks:
        logger.debug(f"uuid = {t['uuid']}")
        logger.debug(f"id = {t['id']}")
        for a in t['annotations']:
            paths = str(a).strip().split('\n')
            for p in paths:
                if p not in excluded_paths:
                    s.add(p)
    return s

def _get_relative_paths(s, drive_path):
    ss = [a.split(drive_path)[1] for a in s]
    return ss

def _drive_sync(ss, drive_path, push):
    logger.debug(f"{type(ss)}")
    op = "push" if push else "pull"
    for path in ss:
        p = subprocess.Popen('cd ' + drive_path + ' && drive ' + op + 
                ' -no-prompt -quiet ' + path, shell=True, 
                stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        stdout, stderr = p.communicate()
        ot = stdout.decode("utf-8").strip()
        logger.debug(f"Trying to execute operation on path {path}")
        if ot == "":
            logger.debug("No results from stdout of drive sync: OK")
        elif ot.find("is set to be ignored yet is being processed") > 0:
            logger.debug("Ignored path")
        else:
            logger.error(f"Error happend for path")

def _task_update(host, tsks, push):
    to_add = host
    to_add += '_pushed' if push else '_pulled'
    # to_del = 'to_push' if push else 'pushed'
    for t in tsks:
        t['tags'].add(to_add)
        if push:
            t['tags'].remove(host+'_to_push')
        else:
            # Check, if everyone has pulled, task done
            involved_hosts = {e[:e.find('_')] for e in t['tags']}
            logger.debug(f"hosts involved = {involved_hosts}")
            if involved_hosts == hosts:
                logger.debug("All hosts have synced, task done")
                t.done()
        t.save()

def main():
    args = _usage()
    print(args)
    #path = os.environ["MDIR_LOGS"] + "/inotify/drive/log3"
    host = socket.gethostname()
    tw = TaskWarrior()
    if not args.push:
        tw.sync()

    drive_path = _get_drive_path()
    tsks = _get_tasks(tw, host, args.push)
    print(tsks)
    excluded_paths = {'LinkAppData/TaskWarrior'}
    s = _compact_changes(tsks)
    if not bool(s):
        print("no changes, exiting")
        return
    logger.debug(f"the final set is {s}")
    # ss = _get_relative_paths(s, drive_path)
    # logger.debug(f"the relative set is {ss}")
    _drive_sync(s, drive_path, args.push)
    _task_update(host, tsks, args.push)

    tw.sync()

if __name__=="__main__":
    handler = logging.StreamHandler()
    formatter = logging.Formatter(
        '%(module)-4s %(levelname)-8s %(funcName)-12s %(message)s')
    handler.setFormatter(formatter)
    logger.addHandler(handler)
    logger.setLevel(logging.DEBUG)

    main()
