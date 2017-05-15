#!/bin/bash

./plot_board.py --out ../out/intermediate ../multivibrator.kicad_pcb && pcb2gcode && ./unify_gcode.py >! ../out/pcb.ngc && gerber2svg -p --out ../out -- ../out/intermediate/multivibrator-F.SilkS.gbr 
