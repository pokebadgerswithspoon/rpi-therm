# rpi-therm

Raspbery PI based Thremometer based on DS18B20 chip: 
- local network web server running on the PI
- postage to internet 
- internet app 

### Screenshot

![Demo](./docs/images/demo.jpg)

Repository contains:
- soldering guide, wire pins of raspberry pi to thermometer and resistor
- a set of scripts to turn raspberry PI into thermometer
- local web server running the PI to show temperature
- application for internet to collect metrics and display temeterure on a public web site


## Shopping list

- Raspberry PI with wifi, i.e. Raspberry PI Zero W
- DS18B20 thermometer waterproof implementation
- Resistor

See more: [shopping list](./docs/shopping-list.md)

## HOWTO

 - [HOWTO](./docs/howto.md)
 - [ansible](./ansible/README.md)

## Developement

### Prerequsites

- sh compatible shell, linux machine or gitbash at least
- ansible
- IDE like vscode
- jdk 17
- helm
- kubectl

## Acknowledgments

- https://albertherd.com/2019/01/02/connecting-a-ds18b20-thermal-sensor-to-your-raspberry-pi-raspberry-pi-temperature-monitoring-part-1/
