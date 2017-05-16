#!/usr/bin/python

import fileinput
import argparse
import re
import math

parser = argparse.ArgumentParser(description='Convert drill file with G85 commands in it to drill file without G85 commands.')
parser.add_argument('drill_files', metavar='project.drl', nargs='*',
                    help='drill files ')
parser.add_argument('--protrusion', '-p', nargs=1, required=True,
                    help='How big to allow a protrusion.  This should be 0.0005 inches in whatever units the input file is using.')

args = parser.parse_args()

tool_sizes = {}
current_tool = None
for line in fileinput.input(args.drill_files):
    tool_create_match = re.match("T(\d+).*C([0-9.]+)", line)
    if tool_create_match:
        tool_number = int(tool_create_match.group(1))
        tool_diameter = float(tool_create_match.group(2))
        tool_sizes[tool_number] = tool_diameter
        print line
        continue
    tool_set_match = re.match("T(\d+)", line)
    if tool_set_match:
        tool_number = int(tool_set_match.group(1))
        current_tool = tool_number
        print line
        continue
    slot_match = re.match("X([0-9.]+)Y([0-9.]+)G85X([0-9.]+)Y([0-9.]+)")
    if slot_match:
        start_x = float(slot_match.group(1))
        start_y = float(slot_match.group(2))
        end_x = float(slot_match.group(3))
        end_y = float(slot_match.group(4))
        distance = math.sqrt((end_x-start_x)*(end_x-start_x)+
                             (end_y-start_y)*(end_y-start_y))
        step = 4*args.protrusion*(tool_sizes[current_tool]-
                                  args.protrusion)
        
