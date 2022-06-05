#!/bin/bash

# Uncomment community [multilib] repository
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Update
pacman -Syyu --needed --noconfirm 2>&1 | grep -v "warning: could not get file information"

# Install Development Packages
pacman -Sy --needed --noconfirm \
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
		libelf \
		lld \
		lz4 \
		llvm \
		multilib-devel \
		ninja \
		openssl \
		patchelf \
		python3 \
		python-pip \
		uboot-tools \
		zstd

# More Packages
pacman -Sy --needed --noconfirm \
	tmate tmux htop

# Symlinks for python an
ln -sf /usr/bin/pip3.10 /usr/bin/pip3
ln -sf /usr/bin/pip3.10 /usr/bin/pip
ln -sf /usr/bin/python3.10 /usr/bin/python3
ln -sf /usr/bin/python3.10 /usr/bin/python

# python and pip version
python3 --version; pip3 --version

# Install Some pip packages
pip3 install \
	telegram-send

echo 'package installtion completed'

