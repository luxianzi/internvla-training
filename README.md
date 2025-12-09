InternVLA Training Container
============================

* Build

  `docker buildx . -t <Container Tag>`

* Run

  Typically, you need to mount your training code and data as a volume. Assuming they are located in the `<Share Directory>`, you can mount them using the `-v` option in the `docker run` command:

  `docker run -v <Share Directory>:/home/worker/share -it --rm --gpus all <Container Tag>`

  The password for the `worker` user is `worker`, in case you need to run commands with `sudo`.

* Docker GPU Support

  GPU support must be enabled in Docker to correctly pass the GPU through to the container. This is accomplished by installing the NVIDIA Container Toolkit (formerly NVIDIA Docker). For more details, see the following:

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

  This container includes a built-in SSH server. You can expose its SSH port by adding a port-forwarding option to the docker run command.

  `docker run -p <Port number>:22 -v <Share Directory>:/home/worker/share -it --rm --gpus all <Container Tag>`

  You can then connect to the container over SSH using <Docker Host IP>:<Port number>. The private keys required for authentication are located in tools/ssh, and the username is worker. For example, if <Docker Host IP> is 172.31.64.97 and <Port number> is 2222, you can connect with the following command:

  `ssh -i tools/ssh/training -p 2222 worker@172.31.64.97`

* Using Dev Containers in VSCode

  You can open the project inside a container by searching for “Dev Containers: Open Folder in Container” from the Command Palette (Ctrl + Shift + P) and selecting the root of the Git repository.

  Note: the container may take some time to build the first time it is opened

  By default, Dev Containers override the container’s entrypoint. Each time you open a terminal in VS Code, it will start as the root user. If you prefer to use the `worker` user instead, you can set "remoteUser" in `.devcontainer/devcontainer.json` to enforce this.

  You can also choose the Python executable from the created conda environment by searching for “Python: Select Interpreter” in the Command Palette.
