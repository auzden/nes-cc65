CC65 = ../../cc65/bin/cc65
CA65 = ../../cc65/bin/ca65
LD65 = ../../cc65/bin/ld65
NAME = space-shooter


$(NAME).nes: $(NAME).o reset.o nes.cfg
	$(LD65) -C nes.cfg -o $(NAME).nes reset.o $(NAME).o nes.lib
	rm *.o
	@echo $(NAME).nes created

reset.o: reset.s
	$(CA65) reset.s

$(NAME).o: $(NAME).s
	$(CA65) $(NAME).s

$(NAME).s: $(NAME).c
	$(CC65) -Oi $(NAME).c --add-source

clean:
	rm $(NAME).nes
