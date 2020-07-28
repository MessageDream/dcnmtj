#!/bin/sh

# 把需要安装软件到容器的命令写在这里

echo '--------------------start------------------------'

if [ "${DEBIAN_REPOSITORIES_REPLACE}" = "true" ]; then
  echo "---------- php replace source ----------"
  mv /etc/apt/sources.list /etc/apt/sources.list.bak
  mv /var/local/source/sources.list /etc/apt/sources.list
  rm -rf /var/local/source
fi

if [ "${TZ}" != "" ]; then
  echo "---------- Undate timezone ----------"
  cp "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" >/etc/timezone
fi

if [ "${MAVEN_VERSION}" != "" ]; then
  echo "---------- Install MAVEN ${MAVEN_VERSION}----------"
  ls -lh /tmp/extensions/${MAVEN_VERSION}
  tar -xvf /tmp/extensions/${MAVEN_VERSION}
  mv apache-maven-3.6.3 /usr/local/maven
  ln -s /usr/local/maven/bin/mvn  /usr/bin/mvn
  echo 'export MAVEN_HOME=/usr/local/maven' >> ~/.profile
  echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> ~/.profile
fi

echo '--------------------end--------------------------'
