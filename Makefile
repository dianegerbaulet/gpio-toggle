#MakeFile pour compiler et installer le programme gpiod.c

#Variables
CFLAGS += $(shell pkg-config --cflags libgpiod)
LDLIBS += $(shell pkg-config --libs libgpiod)
INSTALL_DIR ?= ./.install

#Cible par défaut 
all: gpiod

#compilation implicite de gpio_toggle.c en pgiod
gpiod: gpio_toggle.c
	$(CC) $(CFLAGS) -o gpiod gpio_toggle.c $(LDLIBS)

#cible d'installation
install: gpiod
	mkdir -p $(INSTALL_DIR)
	cp gpiod $(INSTALL_DIR)
	cp esme-led /etc/init.d/esme-led 
	chmod 0755 /etc/init.d/esme-led 

	
#cible clean pour supprimer les fichiers compilés
clean:
	rm -f gpiod *.o
	
	
