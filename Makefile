
all: out/pcb.ngc out/multivibrator-F.SilkS.svg

clean:
	rm -rf out

all_gerber: out/intermediate/multivibrator-B.Cu.gbr out/intermediate/multivibrator.drl out/intermediate/multivibrator-Edge.Cuts.gbr out/intermediate/multivibrator-F.SilkS.gbr

out/intermediate/multivibrator-B.Cu%gbr out/intermediate/multivibrator%drl out/intermediate/multivibrator-Edge.Cuts%gbr out/intermediate/multivibrator-F.SilkS%gbr: src/multivibrator.kicad_pcb
	./scripts/plot_board.py --out out/intermediate src/multivibrator$*kicad_pcb

all_ngc: out/intermediate/back.ngc out/intermediate/drill.ngc out/intermediate/outline.ngc

out/intermediate/back%ngc out/intermediate/drill%ngc out/intermediate/outline%ngc: out/intermediate/multivibrator-B.Cu%gbr out/intermediate/multivibrator%drl out/intermediate/multivibrator-Edge.Cuts%gbr
	pcb2gcode

out/pcb.ngc: out/intermediate/back.ngc out/intermediate/drill.ngc out/intermediate/outline.ngc
	./scripts/unify_gcode.py > out/pcb.ngc

out/multivibrator-F.SilkS.svg: out/intermediate/multivibrator-F.SilkS.gbr
	gerber2svg -p --out out -- out/intermediate/multivibrator-F.SilkS.gbr
