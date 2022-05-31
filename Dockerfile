FROM ummsbiocore/dolphinnext-docker:latest
MAINTAINER Alper Kucukural <alper.kucukural@umassmed.edu>

# dmeta dportal and dsso installation
ENV GITUSER=UMMS-Biocore
RUN git clone https://github.com/${GITUSER}/dmeta.git /var/www/html/dmeta
RUN git clone https://github.com/${GITUSER}/dportal.git /var/www/html/dportal
RUN git clone https://github.com/${GITUSER}/dsso.git /var/www/html/dsso

RUN chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} /var/www/html/dmeta
RUN chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} /var/www/html/dportal
RUN chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} /var/www/html/dsso

# nodejs
RUN apt-get update
RUN apt-get install apt-transport-https sudo
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN npm install nodemon -g
RUN npm install -g n
RUN npm install pm2 -g
RUN n 14.2.0
RUN PATH="$PATH"

RUN npm install -C /var/www/html/dmeta
RUN npm install -C /var/www/html/dportal
RUN npm install -C /var/www/html/dsso

# mongodb https://github.com/docker-library/mongo/blob/master/4.0/Dockerfile

ARG MONGO_PACKAGE=mongodb-org
ARG MONGO_REPO=repo.mongodb.org
ENV MONGO_PACKAGE=${MONGO_PACKAGE} MONGO_REPO=${MONGO_REPO}

ENV MONGO_MAJOR 4.0
ENV MONGO_VERSION 4.0.28
RUN echo "deb [ signed-by=/etc/apt/keyrings/mongodb.gpg ] http://$MONGO_REPO/apt/ubuntu xenial/${MONGO_PACKAGE%-unstable}/$MONGO_MAJOR multiverse" | tee "/etc/apt/sources.list.d/${MONGO_PACKAGE%-unstable}.list"

RUN set -x \
# installing "mongodb-enterprise" pulls in "tzdata" which prompts for input
	&& export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& apt-get install -y --allow-unauthenticated \
		${MONGO_PACKAGE}=$MONGO_VERSION \
		${MONGO_PACKAGE}-server=$MONGO_VERSION \
		${MONGO_PACKAGE}-shell=$MONGO_VERSION \
		${MONGO_PACKAGE}-mongos=$MONGO_VERSION \
		${MONGO_PACKAGE}-tools=$MONGO_VERSION \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/lib/mongodb


# install docker
RUN apt-get -qy full-upgrade 
RUN apt-get install -qy curl 
RUN curl -sSL https://get.docker.com/ | sh

ADD startup /usr/local/bin/startup

EXPOSE 27017


RUN echo "DONE!"

