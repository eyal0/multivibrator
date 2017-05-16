int_dir := out/intermediate



all: out/pcb.ngc out/multivibrator-F.SilkS.svg

clean:
	rm -rf out

all_gerber: $(int_dir)/multivibrator-B.Cu.gbr $(int_dir)/multivibrator.drl $(int_dir)/multivibrator-Edge.Cuts.gbr $(int_dir)/multivibrator-F.SilkS.gbr

$(int_dir)/multivibrator-B.Cu%gbr $(int_dir)/multivibrator%drl $(int_dir)/multivibrator-Edge.Cuts%gbr $(int_dir)/multivibrator-F.SilkS%gbr: src/multivibrator.kicad_pcb
	./scripts/plot_board.py --out $(int_dir) src/multivibrator$*kicad_pcb

$(int_dir)/multivibrator-nog85.drl: $(int_dir)/multivibrator.drl
	./scripts/expand_g85.py -p 0.0127 $^ > $@

panelized_gerber: $(int_dir)/panelized.placement.txt $(int_dir)/panelized-F.SilkS.gbr $(int_dir)/panelized-B.Cu.gbr $(int_dir)/panelized-Edge.Cuts.gbr $(int_dir)/panelized-B.Mask.gbr $(int_dir)/panelized.drl

$(int_dir)/panelized.placement%txt $(int_dir)/panelized-F.SilkS%gbr $(int_dir)/panelized-B.Cu%gbr $(int_dir)/panelized-Edge.Cuts%gbr $(int_dir)/panelized-B.Mask%gbr $(int_dir)/panelized%drl: $(int_dir)/multivibrator-B.Cu%gbr $(int_dir)/multivibrator-nog85%drl $(int_dir)/multivibrator-Edge.Cuts%gbr $(int_dir)/multivibrator-F.SilkS%gbr gerbmerge.cfg
	../../gerbmerge/gerbmerge/gerbmerge.py --full-search -s gerbmerge.cfg

all_ngc: $(int_dir)/back.ngc $(int_dir)/drill.ngc $(int_dir)/outline.ngc

$(int_dir)/back%ngc $(int_dir)/drill%ngc $(int_dir)/outline%ngc: $(int_dir)/panelized-B.Cu%gbr $(int_dir)/panelized%drl $(int_dir)/panelized-Edge.Cuts%gbr $(int_dir)/panelized-F.SilkS%gbr millproject
	../../pcb2gcode/pcb2gcode/pcb2gcode

out/pcb.ngc: $(int_dir)/back.ngc $(int_dir)/drill.ngc $(int_dir)/outline.ngc
	./scripts/unify_gcode.py > out/pcb.ngc

out/multivibrator-F.SilkS.svg: $(int_dir)/multivibrator-F.SilkS.gbr
	gerber2svg -p --out out -- $(int_dir)/multivibrator-F.SilkS.gbr
