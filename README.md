InternVLA Training Container
============================

* Build

  `docker buildx . -t <Container Tag>`

* Run

  `docker run -v <Share Directory>:/home/worker/share -it --rm --gpus all <Container Tag>`

* Docker GPU Support

  We need GPU support in docker to get GPU passed to the container properly. Check the following:

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
