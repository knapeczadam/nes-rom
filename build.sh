export NAME=ROM
export OUT_FOLDER=out
export FILENAME_BASE=$OUT_FOLDER/$NAME

mkdir -p out
ca65 -t nes -l $FILENAME_BASE.lnk -o $FILENAME_BASE.o main.s65
cl65 -t nes -m $FILENAME_BASE.map --config game.cfg -o $FILENAME_BASE.nes $FILENAME_BASE.o

