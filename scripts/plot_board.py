#!/usr/bin/python

'''
    A python script example to create various plot files from a board:
    Fab files
    Doc files
    Gerber files

    Important note:
        this python script does not plot frame references.
        the reason is it is not yet possible from a python script because plotting
        plot frame references needs loading the corresponding page layout file
        (.wks file) or the default template.

        This info (the page layout template) is not stored in the board, and therefore
        not available.

        Do not try to change SetPlotFrameRef(False) to SetPlotFrameRef(true)
        the result is the pcbnew lib will crash if you try to plot
        the unknown frame references template.
    From: https://raw.githubusercontent.com/blairbonnett-mirrors/kicad/master/demos/python_scripts_examples/plot_board.py
    From: http://ci.kicad-pcb.org/job/kicad-doxygen/ws/build/pcbnew/doxygen-python/html/classpcbnew_1_1PCB__PLOT__PARAMS.html
'''

import sys
import os
from pcbnew import *
import argparse
import collections

class readable_dir(argparse.Action):

  def __call__(self,parser, namespace, values, option_string=None):
    prospective_dir=values[0]
    if not os.path.isdir(prospective_dir):
      os.mkdir(prospective_dir)
    if os.access(prospective_dir, os.R_OK):
      setattr(namespace,self.dest,prospective_dir)
    else:
      raise argparse.ArgumentTypeError("{0} is not a readable dir".format(prospective_dir))

class readable_file(argparse.Action):

  def __call__(self,parser, namespace, values, option_string=None):
    if not len(values) == 1:
      raise argparse.ArgumentTypeError("Specify only 1 input file")
    prospective_file=values[0]
    if not os.path.isfile(prospective_file):
      raise argparse.ArgumentTypeError("{0} is not a valid file".format(prospective_file))
    if os.access(prospective_file, os.R_OK):
      setattr(namespace,self.dest,prospective_file)
    else:
      raise argparse.ArgumentTypeError("{0} is not a readable dir".format(prospective_file))

parser = argparse.ArgumentParser(description='Convert kicad project into all the needed files for making PCB.')
parser.add_argument('kicad_pcb_file', metavar='kicad_project.kicad_pcb', action=readable_file, nargs=1,
                    help='kicad .pro file')
parser.add_argument('--out', nargs=1, action=readable_dir,
                    default=os.path.join(os.getcwd(), "out") ,
                    help='where to put the output (default: out diretory in the current path)')

args = parser.parse_args()

filename=os.path.realpath(args.kicad_pcb_file)
board = LoadBoard(filename)
pctl = PLOT_CONTROLLER(board)
popt = pctl.GetPlotOptions()


def set_default_opts(popt, exclude_edge_layer=True):
  popt.SetOutputDirectory(os.path.realpath(args.out))

  # Set some important plot options:
  popt.SetPlotFrameRef(False)
  popt.SetLineWidth(FromMM(0.1))

  popt.SetAutoScale(False)
  popt.SetScale(1)
  popt.SetMirror(False)
  popt.SetUseGerberAttributes(True)
  popt.SetExcludeEdgeLayer(exclude_edge_layer);
  popt.SetUseAuxOrigin(True)

  # This by gerbers only (also the name is truly horrid!)
  popt.SetSubtractMaskFromSilk(False)

LayerPlan = collections.namedtuple('LayerPlan', ["suffix", "layer", "sheet_desc", "set_opts"])
plot_plan = [
    LayerPlan("B.Cu", B_Cu, "Bottom layer",
              lambda: set_default_opts(popt)),
    LayerPlan("F.SilkS", F_SilkS, "Silk top",
              lambda: set_default_opts(popt, exclude_edge_layer=False)),
    LayerPlan("Edge.Cuts", Edge_Cuts, "Edges",
              lambda: set_default_opts(popt)),
]

for layer_info in plot_plan:
    pctl.SetLayer(layer_info[1])
    layer_info.set_opts()
    pctl.OpenPlotfile(layer_info[0], PLOT_FORMAT_GERBER, layer_info[2])
    pctl.PlotLayer()

# Now the drill file
dctl = EXCELLON_WRITER(board)
dctl.SetFormat(True) # millimeters
dctl.CreateDrillandMapFilesSet(os.path.realpath(args.out), True, False)  # Only the drill file
# At the end you have to close the last plot, otherwise you don't know when
# the object will be recycled!
pctl.ClosePlot()
exit(0);
