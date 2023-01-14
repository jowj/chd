#!/usr/bin/env python3
"""Backup digikam files / dbs so I don't lose everything I care about."""
import argparse
import sys
import shutil

FILES = [
    "/home/josiah/.config/digikam_oauthrc",
    "/home/josiah/.config/digikamrc",
    "/home/josiah/.config/digikam_systemrc",

]
DIRECTORIES = [
    "/home/josiah/apps/digikam/"
]

DEST = "/home/josiah/network-share/sainthood/homes/josiah/backups/digikam/"


def resolvepath(path):
    """Resolve and normalize a path

    1.  Handle tilde expansion; turn ~/.ssh into /home/user/.ssh and
        ~otheruser/bin to /home/otheruser/bin
    2.  Normalize the path so that it doesn't contain relative segments, turning
        e.g. /usr/local/../bin to /usr/bin
    3.  Get the real path of the actual file, resolving symbolic links
    """
    return os.path.realpath(os.path.normpath(os.path.expanduser(path)))


def idb_excepthook(type, value, tb):
    """Call an interactive debugger in post-mortem mode
    If you do "sys.excepthook = idb_excepthook", then an interactive debugger
    will be spawned at an unhandled exception
    """
    if hasattr(sys, 'ps1') or not sys.stderr.isatty():
        sys.__excepthook__(type, value, tb)
    else:
        import pdb, traceback
        traceback.print_exception(type, value, tb)
        print
        pdb.pm()


def main(*args, **kwargs):
    parser = argparse.ArgumentParser(
        description="")
    parser.add_argument(
        "--debug", "-d", action='store_true', help="Include debugging output")
    
    parsed = parser.parse_args()
    if parsed.debug:
        sys.excepthook = idb_excepthook

    for item in FILES:
        shutil.copy2(item, DEST)

    for item in DIRECTORIES:
        shutil.copytree(item, DEST, copy_function=shutil.copy2, dirs_exist_ok=True)         
            

if __name__ == "__main__":
    sys.exit(main(*sys.argv))
