#To run this makefile please type the "make" command#

all:	vendingmachinea.vbe \
	vendingmachinej.vbe \
	vendingmachinem.vbe \
	vendingmachineo.vbe \
	vendingmachiner.vbe \
	syf \
	vendingmachinea_o.vbe \
	vendingmachinej_o.vbe \
	vendingmachinem_o.vbe \
	vendingmachiner_o.vbe \
	vendingmachineo_o.vbe \
	boom \
	vendingmachinea_o.vst \
	vendingmachinej_o.vst \
	vendingmachinem_o.vst \
	vendingmachiner_o.vst \
	vendingmachineo_o.vst \
	boog \
	vendingmachinea_l.xsc \
	vendingmachinej_l.xsc \
	vendingmachinem_l.xsc \
	vendingmachiner_l.xsc \
	vendingmachineo_l.xsc \
	loon \
	clean
	@echo "-- Done --"

#----------------- [SYF] -----------------#

vendingmachinea.vbe: vendingmachine.fsm
	@echo "    Encoding Synthesis -> vendingmachinea.vbe"
	syf -CEV -a vendingmachine

vendingmachinej.vbe: vendingmachine.fsm
	@echo "    Encoding Synthesis  -> vendingmachinej.vbe"
	syf -CEV -j vendingmachine
 
vendingmachinem.vbe: vendingmachine.fsm
	@echo "    Encoding Synthesis  -> vendingmachinem.vbe"
	syf -CEV -m vendingmachine
 
vendingmachineo.vbe: vendingmachine.fsm
	@echo "    Encoding Synthesis  -> vendingmachineo.vbe"
	syf -CEV -o vendingmachine
 
vendingmachiner.vbe: vendingmachine.fsm
	@echo "    Encoding Synthesis  -> vendingmachiner.vbe"
	syf -CEV -r vendingmachine

syf:
	mkdir ./SYF
	cp *.vbe ./SYF
	cp *.enc ./SYF

#----------------- [BOOM] -----------------#

vendingmachinea_o.vbe: vendingmachinea.vbe
	@echo "[BOOM] Boolean optimizing -a -> $@"
	boom -V -d 50 vendingmachinea.vbe vendingmachinea_o.vbe
vendingmachinej_o.vbe: vendingmachinej.vbe
	@echo "[BOOM] Boolean optimizing -j -> $@"
	boom -V -d 50 vendingmachinej.vbe vendingmachinej_o.vbe
vendingmachinem_o.vbe: vendingmachinem.vbe
	@echo "[BOOM] Boolean optimizing -m -> $@"
	boom -V -d 50 vendingmachinem.vbe vendingmachinem_o.vbe
vendingmachineo_o.vbe: vendingmachineo.vbe
	@echo "[BOOM] Boolean optimizing -o -> $@"
	boom -V -d 50 vendingmachineo.vbe vendingmachineo_o.vbe
vendingmachiner_o.vbe: vendingmachiner.vbe
	@echo "[BOOM] Boolean optimizing -r -> $@"
	boom -V -d 50 vendingmachiner.vbe vendingmachiner_o.vbe

boom:
	mkdir ./BOOM
	cp *_o.vbe ./BOOM

#----------------- [BOOG] -----------------#

vendingmachinea_o.vst : vendingmachinea_o.vbe
	@echo "[BOOG] Library Mapping -a -> $@ "
	boog -l paramfile vendingmachinea_o
vendingmachinej_o.vst : vendingmachinej_o.vbe
	@echo "[BOOG] Library Mapping -j -> $@ "
	boog -l paramfile vendingmachinej_o
vendingmachinem_o.vst : vendingmachinem_o.vbe
	@echo "[BOOG] Library Mapping -m -> $@ "
	boog -l paramfile vendingmachinem_o
vendingmachineo_o.vst : vendingmachineo_o.vbe
	@echo "[BOOG] Library Mapping -o -> $@ "
	boog -l paramfile vendingmachineo_o
vendingmachiner_o.vst : vendingmachiner_o.vbe
	@echo "[BOOG] Library Mapping -r -> $@ "
	boog -l paramfile vendingmachiner_o

boog:
	mkdir ./BOOG
	cp *.vst ./BOOG
	cp *.xsc ./BOOG

#----------------- [LOON] -----------------#

vendingmachinea_l.xsc : vendingmachinea_o.vst
	@echo "[LOON] Netlist optimizing -a -> $@ "
	loon vendingmachinea_o vendingmachinea_l paramfile
vendingmachinej_l.xsc : vendingmachinej_o.vst
	@echo "[LOON] Netlist optimizing -j -> $@ "
	loon vendingmachinej_o vendingmachinej_l paramfile
vendingmachinem_l.xsc : vendingmachinem_o.vst
	@echo "[LOON] Netlist optimizing -m -> $@ "
	loon vendingmachinem_o vendingmachinem_l paramfile
vendingmachineo_l.xsc : vendingmachineo_o.vst
	@echo "[LOON] Netlist optimizing -o -> $@ "
	loon vendingmachineo_o vendingmachineo_l paramfile
vendingmachiner_l.xsc : vendingmachiner_o.vst
	@echo "[LOON] Netlist optimizing -r -> $@ "
	loon vendingmachiner_o vendingmachiner_l paramfile

loon:
	mkdir ./LOON
	cp *_l.vst ./LOON
	cp *_l.xsc ./LOON

#----------------- [CLEAN] -----------------#

clean :
	rm -f  *.vbe *.enc *.vst *.xsc *~
	@echo "Erase all the files generated by the makefile"
delete:
	rm -rf SYF
	rm -rf BOOM
	rm -rf BOOG
	rm -rf LOON
