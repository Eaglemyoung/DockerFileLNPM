#
# Eagle's Docker stack
#
# Nginx Dockerfile
#

# Base image
FROM debian:testing

MAINTAINER <Eagle_M_Young>

# Update apt
RUN apt-get update

# Install Nginx
RUN apt install nginx-light -y

# Set Nginx as daemon
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose port
EXPOSE 80
EXPOSE 443

# Define default command
CMD ["nginx"]
