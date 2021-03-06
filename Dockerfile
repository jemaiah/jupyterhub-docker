FROM centos:centos6.10

MAINTAINER  Ahmed JEMAI <ahmad.jemai@gmail.com>

WORKDIR /home/jupyterhub
COPY requirements2.txt /home/jupyterhub/
COPY requirements3.txt /home/jupyterhub/
RUN yum install wget java-1.8.0-openjdk.x86_64  -y \
    && wget -q https://repo.anaconda.com/archive/Anaconda2-2019.10-Linux-x86_64.sh \
    && wget -q https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh \
    && sh /home/jupyterhub/Anaconda3-2020.02-Linux-x86_64.sh -b -p /home/jupyterhub/Anaconda3-2020.02 \
    && sh /home/jupyterhub/Anaconda2-2019.10-Linux-x86_64.sh -b -p /home/jupyterhub/Anaconda2-2019.10 \
    && useradd  -m jupyterhub  \
    && rm -rf  /home/jupyterhub/Anaconda3-2020.02-Linux-x86_64.sh \
    && rm -rf /home/jupyterhub/Anaconda2-2019.10-Linux-x86_64.sh \
    && ln -s /home/jupyterhub/Anaconda3-2020.02 /home/jupyterhub/anaconda3 \
    && ln -s /home/jupyterhub/Anaconda2-2019.10  /home/jupyterhub/anaconda2 \
    && /home/jupyterhub/anaconda3/bin/pip install -r /home/jupyterhub/requirements3.txt \
    && /home/jupyterhub/anaconda2/bin/pip install -r /home/jupyterhub/requirements2.txt \
    && chown -R jupyterhub:jupyterhub /home/jupyterhub \
    && yum install -y epel-release vim \
    && yum install -y nodejs  npm  \
    && npm config set strict-ssl false    \
    && npm install -g configurable-http-proxy \
    && usermod -p \$6\$KAOOA89767\$CstslVT58lCwMyMn/SP6euRLh2ejOuteqiVcScacDUBcL\.U7Ree06zS30o7lsYjF114W4WLEVzTRkYcPvKW70I\. root  \
    && mkdir -p /home/jupyterhub/data \
    && mkdir -p /home/jupyterhub/conf \
    && chown jupyterhub /home/jupyterhub/data \ 
    && chown jupyterhub  /home/jupyterhub/conf  \
    && echo "#%PAM-1.0" > /etc/pam.d/jupyterhub \
    &&	echo "auth    requisite pam_succeed_if.so uid >= 500 quiet" >> /etc/pam.d/jupyterhub \
    &&	echo "auth    required  pam_unix.so nodelay" >> /etc/pam.d/jupyterhub \
    &&	echo "account required  pam_unix.so" >> /etc/pam.d/jupyterhub  \
    && openssl rand -base64 16 > /home/jupyterhub/.passwd \
    &&  cat /home/jupyterhub/.passwd  | passwd jupyterhub --stdin  \
    && chown jupyterhub /home/jupyterhub/.passwd  \
    && mkdir /usr/local/share/jupyter   \
    && chown jupyterhub /usr/local/share/jupyter  \
    && /home/jupyterhub/anaconda2/bin/conda clean -a -y \
    && /home/jupyterhub/anaconda3/bin/conda clean -a -y  \
    && yum remove wget -y \
    && yum clean all

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh 

ENTRYPOINT ["docker-entrypoint.sh"]

USER jupyterhub
COPY jupyterhub_config.py /home/jupyterhub/conf/
VOLUME /home/jupyterhub/conf/ /home/jupyterhub/data/
EXPOSE 8000 
CMD      ["/home/jupyterhub/anaconda3/bin/jupyterhub","-f","/home/jupyterhub/conf/jupyterhub_config.py"]
