FROM centos:latest
MAINTAINER Fan <15950194@qq.com>

# Install related packages
RUN yum update -y && \
    yum  -y install vim git gcc gcc-c++ autoconf automake make wget file openssl openssl-devel

#downloads nginx and nginx-rtmp-module,and then compiler them.
RUN mkdir downloads && \
	cd downloads && \
	git clone https://github.com/arut/nginx-rtmp-module.git && \
	wget http://nginx.org/download/nginx-1.11.10.tar.gz && \
	tar zxvf nginx-1.11.10.tar.gz && \
	cd /downloads/nginx-1.11.10 && \
	./configure --add-module=/downloads/nginx-rtmp-module --with-http_ssl_module && \
	make && \
	make install


# start nginx server.
RUN cd /usr/local/nginx/sbin && \
	./nginx

# Print something
RUN echo "welcome to centos_nginx_rtmp server."
