# Use a concrete tag instead of latest!
FROM pytorch/pytorch:latest 

WORKDIR /workspace

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get install -y libsm6 libxext6 libxrender-dev openssh-server net-tools libglvnd-dev

# Setup SSH:
# Set your password in line 17.
EXPOSE 22
# Added -p parameter in case the folders already exist. Otherwise building from Ubuntu image fails.
RUN mkdir -p /root/.ssh
RUN mkdir -p /var/run/sshd
RUN echo 'root:your_password' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# NOTE: Setting environment variables via ENV does not set them inside SSH.
# All of them are being reset, so we have to set them manually.
# Put PATH inside SSH because as it is being reset by default
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "\nPermitUserEnvironment yes" >> /etc/ssh/sshd_config
RUN echo "\nPATH=$PATH" >> ~/.ssh/environment

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN service ssh restart
CMD ["/bin/bash", "-c", "env | grep _ >> /etc/environment && /usr/sbin/sshd -D"]
