# AEM 6.5.11 Image
Based on Alpine Linux 3.15

## Prerequisites
The following items need to be added to this directory in order to this image.

1. AEM cq-quickstart-6.5.0.jar (from Adobe)  
2. license.properties (from Adobe)  
3. AEM 6.5.11 Service Pack (from Adobe)  
4. [ACS Commons 5.1.2 package](https://github.com/Adobe-Consulting-Services/acs-aem-commons/releases/tag/acs-aem-commons-5.1.2)  
5. [AEM Core Components 2.18.0 package](https://github.com/adobe/aem-core-wcm-components/releases/tag/core.wcm.components.reactor-2.18.0)  

## Build
`docker build -t alpine3.15-aem6.5.11author .`

## Run
`docker run -p 4502:4502 -it alpine3.15-aem6.5.11author`

## Push to Registry
`docker push my_registry.azurecr.io/alpine3.15-aem6.5.11author:latest`

---

# WSL2 Setup
To use this for a local development environment, you can run this container in a WSL2 Ubuntu instance.

## Prerequisites
- [Install WSL2](https://docs.microsoft.com/en-us/windows/wsl/install-manual)  
- Install Ubuntu 20.04 (ARM64)  
    ```
    # run in administrator powershell
    Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing 
    Import-Module Appx -usewindowpowershell 
    Add-AppxPackage .\Ubuntu.appx 
    ```

You can additionally use the `.wslconfig` file to limit the amount of resources used by WSL.  
Example .wslconfig:
```
[wsl2]
processors=2
memory=4GB
```

## Setup
1. Copy the `wsl2-docker-bootstrap.sh` script to your Ubuntu WSL2 instance  
    a. run under your user, not root  
2. Run the script  
    a. `./wsl2-docker-bootstrap.sh`  
	b. enter your user password if prompted  
3. Verify docker is installed  
    a. `docker -v`  
	b. `service docker status`  

## Initial Run
0. Open your Ubuntu WSL2 instance after running the bootstrap script  
1. Start the container for the first time:  
    a. `docker run -p 4502:4502 -it alpine3.15-aem6.5.11author`  
2. Wait until the instance is up and you can confirm connection  
    a. check either `http://localhost:4502` or `http://127.0.0.1:4502` to verify AEM is running  
    b. additionally, verify from packmgr that the service pack is installed  
3. From the WSL2 terminal, enter `CTRL + C` to stop the instance  
4. Once the prompt returns, verify the container with `docker ps -a`  
    a. this should show all the container information
	b. write down the NAME of the container for future usage

## Additional Runs
Check if your container is running:  
`docker ps -a`  

Start your container:  
`docker start container_name_here`  

Stop your container:  
`docker stop container_name_here`  

## Startup Job \[BROKEN\]
If you'd like the container to run every time you open the instance, you can install the following cron job:  
`@reboot cd ~ && docker start container_name_here`  

---

# References
- [Alpine image](https://hub.docker.com/_/alpine)
- [Manuall installation for WSL](https://docs.microsoft.com/en-us/windows/wsl/install-manual)
    - [Manual downloads for distributions](https://docs.microsoft.com/en-us/windows/wsl/install-manual#downloading-distributions)
- [WSL2 .wslconfig file](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#configuration-setting-for-wslconfig)
