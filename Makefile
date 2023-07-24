include .env

export PATH := $(WATCOM_PATH):$(PATH)
export INCLUDE := $(WATCOM_INCLUDE):$(INCLUDE)
export WATCOM := $(WATCOM)
export EDPATH := $(EDPATH)
export WIPFC := $(WIPFC)

OBJ_LIST = vga.obj gfx.obj gfx-asm.obj spr.obj timer.obj keyboard.obj bitmap.obj file.obj
TEST_OBJ_LIST = pattern.obj

scroll : clean $(OBJ_LIST) $(TEST_OBJ_LIST)
	cp res/jodi.bmp build/jodi.bmp
	cp res/jodi-spr.bmp build/jodi-spr.bmp
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/test/scroll.c -c -fo=obj/scroll.obj
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) obj/*.obj -fe=build/game.exe

tile : clean $(OBJ_LIST) $(TEST_OBJ_LIST)
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/test/tile.c -c -fo=obj/tile.obj
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) obj/*.obj -fe=build/game.exe

map : clean $(OBJ_LIST)
	cp res/testtile.bmp build/testtile.bmp
	cp res/test.map build/test.map
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/test/map.c -c -fo=obj/map.obj
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) obj/*.obj -fe=build/game.exe

pattern.obj :
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/test/pattern.c -c -fo=obj/pattern.obj

gfx.obj :
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/gfx/gfx.c -c -fo=obj/gfx.obj

gfx-asm.obj :
	$(NASM) src/gfx/gfx.asm -fobj -o obj/gfx-asm.obj -g

spr.obj :
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/gfx/spr.c -c -fo=obj/spr.obj

vga.obj :
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/gfx/vga.c -c -fo=obj/vga.obj

bitmap.obj :
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/io/bitmap.c -c -fo=obj/bitmap.obj

file.obj :
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/io/file.c -c -fo=obj/file.obj

keyboard.obj :
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/io/keyboard.c -c -fo=obj/keyboard.obj

timer.obj :
	wcl386 -zdp -wcd=138 -ecc -4s -mf -fp3 -za -bt=dos -l=$(DOS_EXTENDER) src/io/timer.c -c -fo=obj/timer.obj

run :
	$(DOSBOX) build/game.exe

send :
	kermit -l $(SERIAL_PORT) -b $(SERIAL_SPEED) -i -s build/game.exe

clean :
	rm -f obj/* build/* *.err