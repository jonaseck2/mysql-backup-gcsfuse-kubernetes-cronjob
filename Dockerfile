FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

##

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		mysql-client \
		curl \
	&& rm -rf /var/lib/apt/lists/*

RUN export GCSFUSE_REPO=gcsfuse-jessie \
&& echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list \
&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
&& apt-get -qy update \
&& apt-get -qy install gcsfuse \
&& rm -rf /var/lib/apt/lists/* \
&& mkdir -p /backup

CMD mysqldump | tar cf - | gzip -c > /backup/$(date +\%Y.\%m.\%d.\%H\%M\%S).sql.tgz