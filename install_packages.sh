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
		python3 \
		uboot-tools \
		zstd

# More Packages
pacman -Sy --needed --noconfirm \
	tmate tmux htop

# python and pip version
python --version; pip --version

# Install Some pip packages
pip install \
	telegram-send

cd -

echo 'package installtion completed'

