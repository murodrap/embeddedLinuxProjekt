Build zabezpečuje skript build.sh, ktorému najpru musíme nastaviť práva na spúšťanie (chmod a+x build.sh) a následne ho spustíme príkazom ./build.sh

Image je pre Raspberry pi 1, pracovala som s modelom B. Make v buildroote vytvorí image pre celú sd kartu, stačí ho teda na ňu skopírovať len príkazom sudo dd if=output/images/sdcard.img of=/dev/sdb.

Prehľad príkazov z build.sh
Po tom čo sa naklonuje buildoot repozitár, aplikujeme zmeny z mediaplayer3.patch na konfiguračné súbory, v ktorých potom budeme mať uložené všetky nastavenia potrebné pre náš projekt. Následne spustením make raspberry_defconfig a make zbuildujeme image. Vytvoria sa nám priečinky a súbory, v kotrých ešte budeme musieť vykonať úpravy, aby sme dokázali na raspberry prehrávať hudbu a aby sa zautomatizovalo prehrávanie hudby po vložení usb kľúča. Doplnením "dtparam=audio=on" do output/images/rpi-firmware/config.txt umožníme prehrávanie hudby, do /etc/mdev.conf zase pridáme pravidlo "sd[a-z][0-9]* root:root 660 @/etc/mdev/mount.sh add \$MDEV", ktoré zabezpečí to, že po vložení usb kľúča zavolá sa skript mount.sh z /etc/mdev. Mount.sh bol prevzatý z [1] s tým, že do funkcie obstarávajúcej pridanie zariadenia boli pridané príkazy na nájdenie všetkých .mp3 súborov v zariadení a ich postupné prehranie. Skriptu ešte pridáme práva na spúšťanie a nakoniec znova spustíme make, aby image zahŕňal aj tieto dodatočné zmeny.

Pred odpojením usb kľuča treba zavolať umount na priečinok v /media kam bol po zapojení automaticky namountovaný.

[1] https://linuxlink.timesys.com/docs/wiki/engineering/HOWTO_Automount_USB_using_mdev?fbclid=IwAR2uhuhuF8KxaHeuIDYppLvikiHD-UT17RkFeVXsUKqWFUoFPI5__dUUQrI

