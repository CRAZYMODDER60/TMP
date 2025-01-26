# Use an Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install XRDP and necessary packages
RUN apt-get update && \
    apt-get install -y xrdp xfce4 xfce4-goodies && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set a password for the root user (replace 'rootpassword' with a secure password)
RUN echo "root:a" | chpasswd

# Configure XRDP to use xfce4 as the session
RUN echo "xfce4-session" > /root/.xsession && \
    sed -i 's/3389/3889/' /etc/xrdp/xrdp.ini && \
    service xrdp restart

# Expose the XRDP port
EXPOSE 3889

# Start the XRDP service
CMD ["/usr/sbin/xrdp", "--nodaemon"]
