#Message Funktion
function greenMessage {
    echo -e "\\033[32;1m${@}\033[0m"
}

#okAndSleep
function okAndSleep {
    greenMessage $1
    sleep 1
}

#CheckInstall
function checkInstall {
    if [ "`dpkg-query -s $1 2>/dev/null`" == "" ]; then
        okAndSleep "Installing package $1"
        apt-get install -y $1
    fi
}

#Root Passwort
greenMessage "Bitte setzten sie ein Passwort für den Root Account."
passwd root

#Update durchführen
greenMessage "Updates werden installiert."
apt update
apt --yes upgrade

#FTP-Server installation
greenMessage "Der FTP-Server wird installieren."
apt-get install --yes vsftpd

#SSH-Server installieren
greenMessage "Soll ein SSH-Server installiert werden?"

OPTIONS=("Ja" "Nein")
select SSH in "${OPTIONS[@]}"; do
		case "$REPLY" in
                1|2 ) break;;
                *) errorAndContinue;;
		esac
done
		
if [ "$SSH" == "Ja" ]; then
        greenMessage "Der SSH-Server wird installiert."
        apt-get install --yes openssh-server
fi
