#!/usr/bin/python
import re
import sys
import os
import collections

def fix_line_comments(line):
  return line


tool_dict = {}
def get_tool_number(tool_string):
  global tool_dict
  if tool_string in tool_dict:
    return tool_dict[tool_string]
  else:
    tool_dict[tool_string] = len(tool_dict)+1
    return get_tool_number(tool_string)


tool_change_block = ""
def get_tool_change_block(tool_string):
  global tool_change_block
  if tool_change_block:
    ret = tool_change_block
    ret = re.sub(r"Change tool bit to .*$",
                 r"Change tool bit to " + tool_string + ")",
                 ret,
                 flags=re.MULTILINE)
    ret = re.sub(r"^(M6\s+)\(Tool change.\)",
                 r"\1(" + tool_string + ")",
                 ret,
                 flags=re.MULTILINE)
    ret = re.sub(r"^(T\s*)(.*)",
                 r"\g<1>" + str(get_tool_number(tool_string)),
                 ret,
                 flags=re.MULTILINE)
    return ret
  saved_block = ""
  millproject = get_millproject()
  drill_ngc = os.path.join(millproject["output-dir"], millproject["drill-output"] or "drill.ngc")
  with open(drill_ngc) as drill:
    for line in drill:
      if line == "\n":
        if re.search("^M6", saved_block, re.MULTILINE | re.IGNORECASE):
          tool_change_block = saved_block
          return get_tool_change_block(tool_string)
        saved_block = ""
      else:
        saved_block += fix_line_comments(line)

millproject_dict = collections.defaultdict(lambda: None)
def get_millproject():
  if millproject_dict:
    return millproject_dict
  with open("millproject") as millproject:
    for line in millproject:
      line = re.sub("#.*", "", line)
      line = line.strip()
      m = re.match("\s*([^=]+)\s*=\s*([^=]+)\s*", line)
      if m:
        millproject_dict[m.group(1)] = m.group(2)
  return millproject_dict

def write_add_tool_change(filename, tool_string):
  with open(filename) as lines:
    feed_rate_found = False
    for line in lines:
      if not feed_rate_found and re.match("^F", line, re.IGNORECASE):
        # This is a feed rate command.
        feed_rate_found = True
        sys.stdout.write("\n")
        sys.stdout.write(get_tool_change_block(tool_string))
        sys.stdout.write("\n")
      sys.stdout.write(fix_line_comments(line))

def write_modify_tool_change(filename):
  current_block = ""
  with open(filename) as lines:
    for line in lines:
      current_block += fix_line_comments(line)
      if line == "\n":
        if re.search("^M6", current_block, re.MULTILINE | re.IGNORECASE):
          tool_string = re.search(r"Change tool bit to (.*)\)",
                                  current_block).group(1)
          sys.stdout.write(get_tool_change_block(tool_string))
          sys.stdout.write("\n")
        else:
          sys.stdout.write(current_block)
        current_block = ""

millproject = get_millproject()
back_ngc = os.path.join(millproject["output-dir"], millproject["back-output"] or "back.ngc")
drill_ngc = os.path.join(millproject["output-dir"], millproject["drill-output"] or "drill.ngc")
outline_ngc = os.path.join(millproject["output-dir"], millproject["outline-output"] or "outline.ngc")

#write_add_tool_change(back_ngc, "trace milling tool")
write_modify_tool_change(drill_ngc)
#write_add_tool_change(outline_ngc,
#                       "cutter, diameter " +
#                       str(eval(millproject["cutter-diameter"])) +
#                       " " +
#                       ("inch"
#                        if ("metric" not in millproject
#                            or not eval(millproject["metric"].title()))
#                        else "mm"))
