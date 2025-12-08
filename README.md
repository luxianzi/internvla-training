InternVLA Training Container
============================

* Build

  `docker buildx . -t <Container Tag>`

* Run

  `docker run -v <Share Directory>:/home/worker/share -it --rm --gpus all <Container Tag>`

* Docker GPU Support

  We need GPU support in docker to get GPU passed to the container properly. It is done by installing nvidia runtime to Docker. Check the following:

  ```
  sudo apt update
  sudo apt install curl gnupg2
  curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
      sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
      sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
  sudo apt update
  sudo apt install nvidia-container-toolkit  nvidia-container-toolkit-base  libnvidia-container-tools  libnvidia-container1
  sudo nvidia-ctk runtime configure --runtime=docker
  sudo systemctl restart docker
  ```

* Remote Connection

  There is a built-in SSH server in this container, we could pass a port forwarding argument to docker run command to expose the SSH server port.

  `docker run -p <Port number>:22 -v <Share Directory>:/home/worker/share -it --rm --gpus all <Container Tag>`

  Then we could connect to the container via SSH by `<Docker Host IP>:<Port number>`. The private keys for connection are in tools/ssh, and the user name is worker. For example, if the `<Docker Host IP>` is 172.31.64.97 and the `<Port number>` is 2222, we should be able to connect with the following command:

  `ssh -i tools/ssh/training -p 2222 worker@172.31.64.97`
