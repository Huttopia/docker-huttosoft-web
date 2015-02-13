FROM centos:5.11
MAINTAINER Huttopia <dev@huttopia.com>

# Install Requirements
RUN yum update -y \
    && yum install -y \
        sudo \
        wget \
        curl \
        git \
        apt-utils \
        acl \
        gcc \
        gcc-c++ \
        autoconf \
        automake \
        make \
    && echo "Europe/Paris" > /etc/localtime && yum search -y tzdata && yum update -y tzdata \
    && echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc

# Install PHP & Apache
RUN yum update -y \
    && yum install -y \
        php5 \
        php-mysql \
        php-apc \
        php-pear \
        php-devel \
        curl-devel
        httpd-devel \
        pcre-devel \
        php-xml

# Install Packages PECL
RUN pecl channel-update pecl.php.net \
    && pecl install \
        apc \
        json \
        xml \
        pecl_http-1.7.6 \
        xdebug-2.0.0

# Install Packages PEAR
RUN pear install \
    OLE-1.0.0RC2 \
    Spreadsheet_Excel_Writer-0.9.3

# Config Apache
RUN mkdir /etc/httpd/sites-enabled
ADD assets/conf/httpd.conf /etc/httpd/conf/httpd.conf

# Config PHP
ADD assets/conf/php.ini /etc/php.ini

# Sources
WORKDIR /var/www

EXPOSE 80

VOLUME ["/var/www", "/etc/httpd/sites-enabled"]

# Start
ADD assets/start /bin/start
RUN chmod +x /bin/start

CMD ["bash", "start"]