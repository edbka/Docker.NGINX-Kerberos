FROM nginx:1.13.12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y -qq && apt-get install -y --no-install-recommends \
	build-essential \
	libkrb5-dev \
	libcurl4-openssl-dev \
	curl \
	libpcre3 \
	libpcre3-dev \
	zlib1g-dev \
	krb5-user \
	git	\
	ca-certificates \
	iputils-ping

RUN cd /usr/src && mkdir nginx \
	&& curl -fSL https://nginx.org/download/nginx-1.13.12.tar.gz -o nginx.tar.gz \
	&& tar -xzf nginx.tar.gz -C nginx --strip-components=1

RUN cd /usr/src/nginx \
	&& git clone https://github.com/nirko-rnd/spnego-http-auth-nginx-module.git

RUN cd /usr/src/nginx \
	&& ./configure --with-compat --add-dynamic-module=spnego-http-auth-nginx-module \
	&& make modules \
	&& cp objs/ngx_http_auth_spnego_module.so /etc/nginx/modules/