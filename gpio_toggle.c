#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <gpiod.h>

#define GPIO_CHIP "/dev/gpiochip0"
#define GPIO_LINE 17

int main(void) {
	struct gpiod_chip *chip;
	struct gpiod_line *line;
	int value;
	
	//Ouvre le périphérique GPIO
	chip = gpiod_chip_open(GPIO_CHIP);
	if (!chip) {
		perror("Failed to open GPIO chil");
		return 1;
	}
	
	//Obtient la ligne GPIO #17
	line = gpiod_chip_get_line(chip, GPIO_LINE);
	if (!line) {
		perror("Failed to get GPIO line");
		gpiod_chip_close(chip);
		return 1;
	}
	
	//Configure la ligne GPIO comme sortie
	if(gpiod_line_request_output(line, "gpio-toggle", 0) < 0) {
		perror("Failed to request GPIO line for output");
		gpiod_line_release(line);
		gpiod_chip_close(chip);
		return 1;
	}
	
	//Boucle infinie pour alterner la valeur de la GPIO toutes les secondes
	while(1) {
		//Inverser la valeur
		if(value<0) {
			perror("Failed to read GPIO value");
			break;
		}
		gpiod_line_set_value(line, !value);
		
		printf("GPIO#%d -> %d\n", GPIO_LINE, value);
		
		sleep(1);
	}
	
	//Ferme le périphérique GPIO avant de quitter et libère la ligne
	gpiod_line_release(line);
	gpiod_chip_close(chip);
	return 0;
}
	
