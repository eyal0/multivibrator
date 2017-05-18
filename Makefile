int_dir := out/intermediate

all: out/back_and_outline.ngc out/panelized-F.SilkS.svg out/panelized-B.Mask.svg out/drill.ngc

clean:
	rm -rf out

all_gerber: $(int_dir)/multivibrator-B.Cu.gbr $(int_dir)/multivibrator.drl $(int_dir)/multivibrator-Edge.Cuts.gbr $(int_dir)/multivibrator-F.SilkS.gbr

$(int_dir)/multivibrator-B.Cu%gbr $(int_dir)/multivibrator%drl $(int_dir)/multivibrator-Edge.Cuts%gbr $(int_dir)/multivibrator-F.SilkS%gbr: src/multivibrator.kicad_pcb ./scripts/plot_board.py
	./scripts/plot_board.py --out $(int_dir) src/multivibrator$*kicad_pcb

panelized_gerber: $(int_dir)/panelized.placement.txt $(int_dir)/panelized-F.SilkS.gbr $(int_dir)/panelized-B.Cu.gbr $(int_dir)/panelized-Edge.Cuts.gbr $(int_dir)/panelized-B.Mask.gbr $(int_dir)/panelized.drl

$(int_dir)/panelized.placement%txt $(int_dir)/panelized-F.SilkS%gbr $(int_dir)/panelized-B.Cu%gbr $(int_dir)/panelized-Edge.Cuts%gbr $(int_dir)/panelized-B.Mask%gbr $(int_dir)/panelized%drl: $(int_dir)/multivibrator-B.Cu%gbr $(int_dir)/multivibrator%drl $(int_dir)/multivibrator-Edge.Cuts%gbr $(int_dir)/multivibrator-F.SilkS%gbr gerbmerge.cfg
	../../gerbmerge/gerbmerge/gerbmerge.py --full-search -s gerbmerge.cfg

all_ngc: $(int_dir)/back.ngc $(int_dir)/drill.ngc $(int_dir)/outline.ngc

$(int_dir)/back%ngc $(int_dir)/drill%ngc $(int_dir)/outline%ngc: $(int_dir)/panelized-B.Cu%gbr $(int_dir)/panelized%drl $(int_dir)/panelized-Edge.Cuts%gbr $(int_dir)/panelized-F.SilkS%gbr millproject
	../../pcb2gcode/pcb2gcode/pcb2gcode

out/back_and_outline.ngc: $(int_dir)/back.ngc $(int_dir)/drill.ngc $(int_dir)/outline.ngc ./scripts/back_and_outline_gcode.py
	./scripts/back_and_outline_gcode.py > $@

out/drill.ngc: $(int_dir)/back.ngc $(int_dir)/drill.ngc $(int_dir)/outline.ngc ./scripts/drill_gcode.py
	./scripts/drill_gcode.py > $@

out/panelized-F.SilkS.svg: $(int_dir)/panelized-F.SilkS.gbr
	gerber2svg -c 0 -p -- $^ | scripts/fix_svg_color.py -c black > $@

out/panelized-B.Mask.svg: $(int_dir)/panelized-B.Mask.gbr
	gerber2svg -c 0 -p -- $^ | scripts/fix_svg_color.py -c black > $@

.DELETE_ON_ERROR:
