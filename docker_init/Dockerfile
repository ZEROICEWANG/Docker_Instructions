FROM nvidia/cuda:11.4.3-cudnn8-devel-ubuntu18.04

MAINTAINER xxx xxx <xxx@xxx.edu.cn>

USER root

# Install some essential tools
RUN apt update && apt install -y \
  sudo \
  wget \
  curl \
  vim \
  git \
  build-essential \
  cmake \
  checkinstall \
  pkg-config \
  openssh-server \
  openssh-client \
  iputils-ping \
  zip \
  unzip \
  p7zip \
  tmux \
  htop \
  iftop \
  iotop \
  libxmu6 \
  libsm6 \
  libxext-dev \
  libxrender1 \
  libgl1-mesa-glx

# Install Miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda.sh && \
  /bin/bash Miniconda.sh -b -p /opt/conda && \
  rm Miniconda.sh
ENV PATH /opt/conda/bin:$PATH

# Create the directories that will be used in the docker run command to mount the volumes on the host machine
RUN mkdir /home/data /home/share

# SSH settings
RUN mkdir /var/run/sshd
# Replace the "session required pam_loginuid.so" in /etc/pam.d/sshd with "session optional pam_loginuid.so"
# But it seems that this is not needed in the new versions of docker. See https://gitlab.com/gitlab-org/gitlab-foss/-/issues/3027
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22

# Add cuda and conda paths
# RUN echo "export PATH=/usr/local/cuda/bin:/usr/local/nvidia/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" >> /etc/profile
RUN echo "export PATH=/usr/local/cuda/bin:/usr/local/nvidia/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/conda/bin" >> /etc/profile
RUN echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/nvidia/lib64:/usr/lib64:/usr/local/lib:/usr/lib:/usr/lib/x86_64-linux-gnu" >> /etc/profile

# Clean up all temp files
RUN apt clean && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/*

# Set the entrypoint
COPY ./init_container.sh /usr/local/bin/init_container.sh
RUN chmod +x /usr/local/bin/init_container.sh
ENTRYPOINT ["/usr/local/bin/init_container.sh"]