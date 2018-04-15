FROM debian:jessie-slim

RUN export GCSFUSE_REPO=gcsfuse-jessie \
&& apt-get -qy update \
&& apt-get -qy install curl \
&& echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list \
&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
&& apt-get -qy update \
&& apt-get -qy install gcsfuse mysql-client \
&& rm -rf /var/lib/apt/lists/*