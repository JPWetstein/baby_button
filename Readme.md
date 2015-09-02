# The Baby Button

This is a simple test project for hacking your amazon dash button into something useful, like a silent doorbell for when
the baby's sleeping. Many thanks to Ted Benson and his [excellent article](https://medium.com/@edwardbenson/how-i-hacked-amazon-s-5-wifi-button-to-track-baby-data-794214b0bdd8)
for getting me started.

## Software setup:

This is tested on a Mac, it should work in Linux. If you're working in Windows,
I encourage you to switch to one of the others for ruby development.

1. Install ruby (insert link)
2. Install rubygems (insert link)
3. Install the bundler gem **with sudo** ('sudo gem install bundler')
4. Install the other gems **with sudo** ('sudo bungle install')

## Button setup:

Setup by following Amazon's instructions, but on the last step, don't select a product to order.

## Configuration:

 * network interface: run 'ifconfig' and find the one with 'status: active'
 * phone number: 10 digit phone number
 * carrier: find your carrier's value from [here](https://github.com/preston/sms-easy#numbers-and-carriers)
 * message: what you want your text to say
 * arp source:
     * run 'sudo ruby sniffer.rb'
     * click your dash button
     * use the number that shows up on your screen
     * press ctrl-c to exit
 * email: A gmail account to send texts from
 * password: The password for the gmail account

## Running it:

 * run 'sudo ruby baby_button.rb'
 * press ctrl-c to exit

## Todo:

 * Figure out if there's a way to do this without running everything through sudo!
 * Separate dash functionality into its own gem
 * Clean stuff up generally