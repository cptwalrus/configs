# Simple script to setup basic folders for neovim and link init.vim and pull plug.vim

INITVIM="$PWD/init.vim"
INITVIMDIR="$HOME/.config/nvim"
INITVIMDEST="$INITVIMDIR/init.vim"

VIMPLUGREMOTE="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
VIMPLUGDIR="$HOME/.config/nvim/autoload"
VIMPLUGINST="$VIMPLUGDIR/plug.vim"

echo "[-] Creating folders for init.vim and symlinking from here..."
mkdir -p $INITVIMDIR
ln -s $INITVIM $INITVIMDEST
echo "[+] Init.vim installed and linked"

echo "[-] Checking for python3-pip..."
if [ $(dpkg-query -W -f='${Status}' python3-pip 2>/dev/null | grep -c "ok installed")  -eq 0 ]
then
	echo "[*] python3-pip not installed, installing now..."
	sudo apt install python3-pip
	echo "[+] python3-pip installed!"
else
	echo "[+] python3-pip already installed!"
fi


echo "[-] Checking for pynvim"
if [ $(pip3 list 2>/dev/null | grep -c "pynvim") -eq 0 ]
then
	echo "[*] pynvim not installed, installing now..."
	pip3 install pynvim
	echo "[+] pynvim installed!"
else
	echo "[+] pynvim already installed!"
fi

echo "[-] Creating paths and installing vim-plug"

mkdir -p $VIMPLUGDIR
curl -fLo $VIMPLUGINST $VIMPLUGREMOTE

echo "[+] Installed vim-plug"
echo "[+] Installation finished!"
