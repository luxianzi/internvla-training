FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu24.04 AS intermediate

COPY ./files/init-dep.sh ./files/init-user.sh /usr/bin/
ARG UID=1000
ARG USERNAME=worker
RUN init-dep.sh && rm /usr/bin/init-dep.sh && init-user.sh && rm /usr/bin/init-user.sh

USER $USERNAME
WORKDIR /home/$USERNAME/

COPY ./files/init-conda.sh /home/$USERNAME/
RUN /home/$USERNAME/init-conda.sh && rm /home/$USERNAME/init-conda.sh
COPY ./files/internvla-m1.yml /home/$USERNAME/
COPY ./files/init-training.sh /home/$USERNAME/
RUN /home/$USERNAME/init-training.sh && rm /home/$USERNAME/init-training.sh && rm /home/$USERNAME/internvla-m1.yml
