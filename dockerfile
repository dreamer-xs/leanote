FROM centos:latest
MAINTAINER  xushun@svi-tech.com.cn
RUN  yum -y  install vim  ifconfig  curl wget  net-tools netstat git

ENV LEANOTE_VERSION 2.4
ENV MONGO_VERSION 3.0.1
ENV APP_SECRET=V85ZzBeTnzpsHyjQX4zuKbQ8qqtJu9y2aDM55VWxAH1Q0p19poekx3LkcDIvrD0y

WORKDIR /usr/local/bin/
COPY start.sh  .

#download software
RUN wget https://nchc.dl.sourceforge.net/project/leanote-bin/${LEANOTE_VERSION}/leanote-linux-amd64-v${LEANOTE_VERSION}.bin.tar.gz
RUN wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${MONGO_VERSION}.tgz

#COPY leanote-linux-amd64-v${LEANOTE_VERSION}.bin.tar.gz /usr/local/bin
#COPY mongodb-linux-x86_64-${MONGO_VERSION}.tgz /usr/local/bin

RUN  tar xf leanote-linux-amd64-v${LEANOTE_VERSION}.bin.tar.gz
RUN  tar xf mongodb-linux-x86_64-${MONGO_VERSION}.tgz

RUN  echo "export PATH=$PATH:/usr/local/bin/mongodb-linux-x86_64-${MONGO_VERSION}/bin" >> /etc/profile
RUN  sed -i "s#app.secret.*#app.secret=${APP_SECRET}#g" /usr/local/bin/leanote/conf/app.conf

EXPOSE 9000


CMD bash start.sh
