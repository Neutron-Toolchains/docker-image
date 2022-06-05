#!/bin/bash

# Uncomment community [multilib] repository
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Update
pacman -Syyu --needed --noconfirm 2>&1 | grep -v "warning: could not get file information"

# Install Basic Packages
pacman -Sy --needed --noconfirm \
	sudo nano git curl wget rsync aria2 rclone \
	python3 python-pip zip unzip cmake make \
	neofetch speedtest-cli inetutils cpio repo\
	jdk-openjdk lzip dpkg openssl ccache go \
	libelf base-devel openssh lz4 jq z3 ncurses \
	bison flex ninja uboot-tools bc glibc dpkg \
	multilib-devel man htop python-setuptools   \
	util-linux

# More Packages
pacman -Sy --needed --noconfirm \
	tmate tmux screen mlocate unace unrar p7zip \
	sharutils uudeview arj cabextract file-roller \
	dtc brotli axel gawk detox clang gcc gcc-libs \
	flatpak

# python and pip version
python --version; pip --version

# Install Some pip packages
pip install \
	twrpdtgen telegram-send backports.lzma docopt \
	extract-dtb protobuf pycrypto docopt zstandard \
	setuptools

# pip git packages
pip install \
	git+https://github.com/samloader/samloader.git

# Create a non-root user for AUR
useradd -m -G wheel -s /bin/bash testuser
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# AUR Packages
sudo -u testuser yay -S --needed --noconfirm \
	rename

# Setup the Android Build Environment
cd /tmp/scripts
sudo chmod -R a+rwx .
sudo -u testuser bash ./aosp-build-env.sh
cd -

