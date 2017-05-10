FROM centos:latest
MAINTAINER  xushun@svi-tech.com.cn
RUN  yum -y  install vim  ifconfig  curl wget  net-tools netstat git

ENV LEANOTE_VERSION 2.4
ENV MONGO_VERSION 3.0.1
ENV APP_SECRET=V85ZzBeTnzpsHyjQX4zuKbQ8qqtJu9y2aDM55VWxAH1Q0p19poekx3LkcDIvrD0y

WORKDIR /usr/local/bin/

#download software
RUN wget https://nchc.dl.sourceforge.net/project/leanote-bin/${LEANOTE_VERSION}/leanote-linux-amd64-v${LEANOTE_VERSION}.bin.tar.gz
RUN wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${MONGO_VERSION}.tgz

#COPY leanote-linux-amd64-v${LEANOTE_VERSION}.bin.tar.gz /usr/local/bin
#COPY mongodb-linux-x86_64-${MONGO_VERSION}.tgz /usr/local/bin

RUN  tar xf leanote-linux-amd64-v${LEANOTE_VERSION}.bin.tar.gz
RUN  tar xf mongodb-linux-x86_64-${MONGO_VERSION}.tgz
RUN  echo "export PATH=$PATH:/usr/local/bin/mongodb-linux-x86_64-${MONGO_VERSION}/bin" >> /etc/profile 
RUN  . /etc/profile
RUN  sed -i "s#app.secret.*#app.secret=${APP_SECRET}#g" /usr/local/bin/leanote/conf/app.conf 
RUN  mkdir /usr/local/bin/mongodb-linux-x86_64-${MONGO_VERSION}/data
RUN  /usr/local/bin/mongodb-linux-x86_64-${MONGO_VERSION}/bin/mongod --dbpath  /usr/local/bin/mongodb-linux-x86_64-${MONGO_VERSION}/data & sleep 50 \
     && /usr/local/bin/mongodb-linux-x86_64-${MONGO_VERSION}/bin/mongorestore -h localhost -d leanote --dir /usr/local/bin/leanote/mongodb_backup/leanote_install_data
    
EXPOSE 9000

WORKDIR /usr/local/bin/leanote/bin/

CMD  . /etc/profile && mongod --dbpath  /usr/local/bin/mongodb-linux-x86_64-${MONGO_VERSION}/data & sleep 30 && bash run.sh

