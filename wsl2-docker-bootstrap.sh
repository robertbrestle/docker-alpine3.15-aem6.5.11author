#https://dev.to/felipecrs/simply-run-docker-on-wsl2-3o8
# Ensures not older packages are installed
sudo apt-get remove docker docker-engine docker.io containerd runc

# Ensure pre-requisites are installed
sudo apt-get update
sudo apt upgrade -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

# Adds docker apt repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Adds docker apt key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Refreshes apt repos
sudo apt-get update

# Installs Docker CE
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# ensures docker group exists
sudo groupadd docker

sudo usermod -aG docker $USER

# enable docker daemon on WSL2 startup
echo -e "\n# automatically start the docker daemon\nif service docker status 2>&1 | grep -q \"is not running\"; then\n\twsl.exe -d \"${WSL_DISTRO_NAME}\" -u root -e /usr/sbin/service docker start >/dev/null 2>&1\nfi" >> ~/.profile

#https://dev.to/icy1900/auto-start-cron-in-wsl2-1lk1
# enable cron on WSL2 startup
#sudo echo -e "if ! service cron status &> /dev/null; then\n\tsudo service cron start\nfi" > /etc/profile/start_cron.sh
#sudo chmod +x /etc/profile/start_cron.sh
