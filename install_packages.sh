#!/bin/bash

# Uncomment community [multilib] repository
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Refresh mirror list
pacman-key --init
pacman -Syu --noconfirm reflector rsync curl git base-devel 2>&1 | grep -v "warning: could not get file information"
reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Download fresh package databases from the servers
pacman -Syy

# Create a non-root user for yay to install packages from AUR
useradd -m -G wheel -s /bin/bash auruser
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# AUR Packages
sudo -u auruser yay -S --noconfirm \
	alhp-keyring alhp-mirrorlist

# Enable ALHP repos
sed -i 's/#Server/Server/g' /etc/pacman.d/alhp-mirrorlist
sed -e '/Worldwide/,+1 s/^/#/' /etc/pacman.d/alhp-mirrorlist
sed -i "/\[core-x86-64-v3\]/,/Include/"'s/^#//' /etc/pacman.conf
sed -i "/\[extra-x86-64-v3\]/,/Include/"'s/^#//' /etc/pacman.conf
sed -i "/\[community-x86-64-v3\]/,/Include/"'s/^#//' /etc/pacman.conf

# Update
pacman -Syyu --noconfirm 2>&1 | grep -v "warning: could not get file information"

# Install Development Packages
pacman -Sy --noconfirm \
	sudo \
	nano \
	git \
	curl \
	wget \
	rsync \
	aarch64-linux-gnu-binutils \
	base-devel \
	bc \
	bison \
	ccache \
	clang \
	cpio \
	cmake \
	flex \
	gcc \
	gcc-libs \
	github-cli \
	gperf \
	jemalloc \
	jdk-openjdk \
	libelf \
	lld \
	lz4 \
	llvm \
	multilib-devel \
	ninja \
	openssl \
	patchelf \
	perf \
	perl \
	python3 \
	python-pip \
	uboot-tools \
	zip \
	zstd

# More Packages
pacman -Sy --noconfirm \
	tmate tmux htop

# Symlinks for python an
ln -sf /usr/bin/pip3.10 /usr/bin/pip3
ln -sf /usr/bin/pip3.10 /usr/bin/pip
ln -sf /usr/bin/python3.10 /usr/bin/python3
ln -sf /usr/bin/python3.10 /usr/bin/python

# python and pip version
python3 --version
pip3 --version

# Install Some pip packages
pip3 install \
	telegram-send

echo 'package installtion completed'
