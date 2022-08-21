FROM pytorch/pytorch:latest

WORKDIR /workspace

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get install -y libsm6 libxext6 libxrender-dev openssh-server net-tools libglvnd-dev

# Setup SSH
EXPOSE 22
RUN mkdir /root/.ssh
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# NOTE: Setting environment variables via ENV does not set them inside SSH.
# All of them are being reset, so we have to set them manually.
# Put PATH inside SSH because as it is being reset by default
RUN echo "export PATH=$PATH" >> /etc/profile

# The other way to put PATH inside SSH
# RUN echo "\nPermitUserEnvironment yes" >> /etc/ssh/sshd_config
# RUN echo "\nPATH=$PATH" >> ~/.ssh/environment

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN service ssh restart
CMD ["/bin/bash", "-c", "env | grep _ >> /etc/environment && /usr/sbin/sshd -D"]