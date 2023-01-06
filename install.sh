#!/bin/bash

if ! [ -x /usr/local/bin/massdns ] ; then
	echo "[+] cloning from blechschmidt/massdns" && sleep 0.5
	git clone https://github.com/blechschmidt/massdns && cd massdns && echo "[+] sudo make && make install" && 
	sleep 0.5
	sudo make && sudo make install && sleep 0.5 && echo "[!] all done!"
	sleep 0.5
	echo "[-] cleaning up ..."
	cd ../ && sudo rm -rf massdns/ && echo "[-] all done ... exiting"
fi

if [ -x /usr/local/bin/massdns ] ; then
	echo "[-] massdns binary is present in:"
	sleep 0.5
	which massdns
	echo "[-] ./run.sh resources/alexa.txt"
fi

