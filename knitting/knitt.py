#! /usr/bin/env python
"""
Generates a preview from the accompanying knitting instructions.

tac ${INSTRUCTIONS} | ./knitt.py
"""
__copyright__ = "Copyright 2012, b@Zi.iS"
__license__ = "GPLv2"

import fileinput
import sys
from termcolor import colored
from optparse import OptionParser

def knitt(instructions, verbose):
    card=[]
    buf=['']
    cariage='                        '
    for line in instructions:
        if line[0] == '|':
            card.append(line[1:-1])
        elif line[0].isdigit():
            line = line.split()
            if line[4] != 'waste' and line[4] != 'ravel':
                for x in range(int(line[0])):
                    for y in range(int(line[1].split('/')[0])):
                        if not('/' in line[1]) or y % int(line[1].split('/')[1]) == 0:
                            if line[3]=='O':
                                buf[-1] += colored('X', line[4])
                            elif line[3]=='F':
                                buf[-1] += colored('X', line[4].split('/')[0 if cariage[y%24]==' ' else 1])
                        else:
                            buf[-1] += ' '
                    buf.append('')
                    if len(card)>0:
                        cariage=card.pop()
                    else:
                        cariage='                          '
        elif verbose:
            buf[-1] = line[:-1]
            buf.append('')
    for line in reversed(buf):
        print line

if __name__ == "__main__":
    parser = OptionParser("usage: %prog [options] [files ...]")
    parser.add_option(
        "-q",
        "--quiet",
        action="store_false",
        dest="verbose",
        default=True,
        help="don't print text instructions"
    )
    
    (options, args) = parser.parse_args()
    knitt(fileinput.input(args), options.verbose)
