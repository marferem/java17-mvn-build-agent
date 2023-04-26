FROM rockylinux:9.1

RUN dnf update -y

RUN dnf install java-17-openjdk java-17-openjdk-devel -y

RUN dnf install wget -y

RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.1/binaries/apache-maven-3.9.1-bin.tar.gz -P /tmp

RUN tar xf /tmp/apache-maven-3.9.1-bin.tar.gz -C /opt

RUN ln -s /opt/apache-maven-3.9.1 /opt/maven

# ENV JAVA_HOME=/usr/lib/jvm/jre-openjdk
# ENV M2_HOME=/opt/maven
# ENV MAVEN_HOME=/opt/maven
# ENV PATH=${M2_HOME}/bin:${PATH}

COPY profile /etc/profile

RUN adduser jenkins &&                      \
    echo "jenkins:jenkins" | chpasswd &&    \
    mkdir /home/jenkins/.m2


RUN dnf install -y openssh-server
RUN dnf install -y git

RUN mkdir -p /var/run/sshd

#RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd 

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys
RUN chmod 600 /home/jenkins/.ssh/authorized_keys

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/

EXPOSE 22

WORKDIR /etc/ssh

RUN ssh-keygen -A

CMD ["/usr/sbin/sshd", "-D"]