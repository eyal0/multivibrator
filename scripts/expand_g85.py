#!/usr/bin/python

from __future__ import division

import fileinput
import argparse
import re
import math
import collections

parser = argparse.ArgumentParser(description='Convert drill file with G85 commands in it to drill file without G85 commands.')
parser.add_argument('drill_files', metavar='project.drl', nargs='*',
                    help='drill files ')
parser.add_argument('--protrusion', '-p', nargs=1, required=True,
                    help='How big to allow a protrusion.  This should be 0.0005 inches in whatever units the input file is using.')

args = parser.parse_args()

def shuffle_steps(l):
    '''Given a list, yield the elements such that they are returned in
     the order where each returned element has the greatest distance
     from the previously returned element.
    '''
    if len(l) == 0:
        return
    if len(l) == 1:
        yield l[0]
    bfs = collections.deque()
    yield l[0]
    yield l[-1]
    bfs.append((1,len(l)-2))
    while bfs:
        start, end = bfs.popleft()
        if start > end:
            continue
        mid = int(math.floor(start/2.0+end/2.0))
        yield l[mid]
        bfs.append((start, mid-1))
        bfs.append((mid+1, end))

tool_sizes = {}
current_tool = None
protrusion = float(args.protrusion[0])
for line in fileinput.input(args.drill_files):
    tool_create_match = re.match("T(\d+).*C([0-9.]+)", line)
    if tool_create_match:
        tool_number = int(tool_create_match.group(1))
        tool_diameter = float(tool_create_match.group(2))
        tool_sizes[tool_number] = tool_diameter
        print line,
        continue
    tool_set_match = re.match("T(\d+)", line)
    if tool_set_match:
        tool_number = int(tool_set_match.group(1))
        current_tool = tool_number
        print line,
        continue
    slot_match = re.match("X([-0-9.]+)Y([-0-9.]+)G85X([-0-9.]+)Y([-0-9.]+)", line)
    if slot_match:
        start_x = float(slot_match.group(1))
        start_y = float(slot_match.group(2))
        end_x = float(slot_match.group(3))
        end_y = float(slot_match.group(4))
        distance = math.sqrt((end_x-start_x)*(end_x-start_x)+
                             (end_y-start_y)*(end_y-start_y))
        step_size = math.sqrt(4*protrusion*(tool_sizes[current_tool]-
                                            protrusion))
        drill_count = int(math.ceil(distance/step_size))+1  # The number of drill holes to make
        for drill in shuffle_steps(xrange(drill_count)):
            ratio = drill/(drill_count-1)
            x = start_x * (1-ratio) + end_x * (ratio)
            y = start_y * (1-ratio) + end_y * (ratio)
            print ("X%fY%f" % (x, y))
        continue
    print line,
