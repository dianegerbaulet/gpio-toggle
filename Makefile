#MakeFile pour compiler et installer le programme gpiod.c

#Variables
CFLAGS += $(shell pkg-config --cflags libgpiod)
LDLIBS += $(shell pkg-config --libs libgpiod)
INSTALL_DIR ?= ./.install

#Cible par défaut 
all: gpiod

#compilation implicite de gpio_toggle.c en pgiod
gpiod: gpiod.o

#cible d'installation
install: gpiod
	install -m 0755 -d $(INSTALL_DIR)/usr/bin
	install -m 0755 gpiod $(INSTALL_DIR)/usr/bin
	install -m 0755 -d $(INSTALL_DIR)/etc/init.d
	install -m 0755 esme-led $(INSTALL_DIR)/etc/init.d
	
#cible clean pour supprimer les fichiers compilés
clean:
	rm -f gpiod *.o
	
	
