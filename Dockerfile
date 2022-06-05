# Base Image
FROM archlinux:base-devel

# User
USER root

# Working Directory
WORKDIR /root

# Remove Files before copying the Rootfs
COPY remove /tmp/
RUN rm -rf $(< /tmp/remove)

# Copy Rootfs and Scripts
COPY rootfs /

# Install Packages
COPY ./install_packages.sh /tmp/
RUN bash /tmp/install_packages.sh

# Configuration
COPY ./config.sh /tmp/
RUN bash /tmp/config.sh

# Remove the Scripts we used
RUN rm -rf /tmp/{{install_packages,config}.sh,remove}

# docker run command
CMD ["bash"]
