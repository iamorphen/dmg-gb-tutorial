# The DMG (GB) Programming Tutorial
The DMG (Dot Matrix Game) (aka GameBoy) programming tutorial features implementations of various things on the original GameBoy for instruction's sake.

Assembly is written for the [RGBDS toolchain](https://github.com/rednex/rgbds) (v0.3.3). ROMs are tested in [BGB](http://bgb.bircd.org/) (v 1.5.5) running through [Wine](https://wiki.winehq.org/Ubuntu) on Ubuntu 16.04.

# Building
Simply call `make` from the project root folder to build the ROMs. The ROMs are placed in `./build`.

If you don't have make, you can run the following commands (modify as needed):
```
cd <project_root>
mkdir -p build
rgbasm -i ./ -o build/character_writer.o character_writer/main.asm
rgblink -o build/character_writer.gb build/character_writer.o
rgbfix -v build/character_writer.gb
```

# License
MIT license; see LICENSE.md.

# Disclaimers
`include/cp437.asm` is a modified version of "IBMPC1.TXT" from the GALP (GameBoy Assembly Language Primer) resources. At the time of this writing, the resources can be [found here](http://www.devrs.com/gb/files/galp.zip).
