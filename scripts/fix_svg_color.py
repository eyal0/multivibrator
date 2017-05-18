#!/usr/bin/python

from __future__ import division

import fileinput
import argparse
import re
import math
import collections

parser = argparse.ArgumentParser(description='Change color in svg file made by gerber2svg.')
parser.add_argument('svg_files', metavar='project.svg', nargs='*',
                    help='svg files')
parser.add_argument('--color', '-c', nargs=1, required=True,
                    help='The new color to use.')

args = parser.parse_args()

for line in fileinput.input(args.svg_files):
    print re.sub(r'''(stroke)(\s*=\s*['"])([^'"]*)''', r'''\1\2''' + args.color[0], line),
