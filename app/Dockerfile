# Get from alpine image
# FROM alpine:3.15
FROM public.ecr.aws/docker/library/alpine:3.15

# Open 80 port
EXPOSE 80

# Description of project
LABEL author="Student" \
      description="Test images with Alpine" \
      test="Test GitHub Action"

# Install Apache, PHP
RUN set -e && \
    apk update && apk upgrade && \
    apk add --no-cache sudo \
        curl \
        openrc \
        apache2 \
        php8 \
        php8-apache2 && \
    # Remove index.html from container
    rm -rf /var/www/localhost/htdocs/index.html && \
    # Update and start apache
    rc-update add apache2 && \
    rm -rf /var/cache/apk/*

# COPY files and dirs
COPY httpd.conf /etc/apache2/httpd.conf
COPY htdocs /var/www/localhost/htdocs

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
