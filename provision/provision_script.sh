### Install docker
apt-get remove docker docker-engine docker.io containerd runc -y

apt-get update -y
apt-get upgrade -y
apt-get install ca-certificates curl gnupg lsb-release conntrack socat -y

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

chmod a+r /etc/apt/keyrings/docker.gpg

apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

### Docker post-installation steps
groupadd docker
usermod -aG docker vagrant

systemctl enable docker.service
systemctl enable containerd.service

### Get arkade
curl -sLS https://get.arkade.dev | sh

# Install crictl
VERSION="v1.28.0"
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz

# Install cri-dockerd
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.9/cri-dockerd_0.3.9.3-0.ubuntu-bionic_amd64.deb -P /usr/local/src
dpkg -i /usr/local/src/cri-dockerd_0.3.9.3-0.ubuntu-bionic_amd64.deb

# Install containernetwork-plugins
CNI_PLUGIN_VERSION="v1.4.0"
CNI_PLUGIN_TAR="cni-plugins-linux-amd64-$CNI_PLUGIN_VERSION.tgz" # change arch if not on amd64
CNI_PLUGIN_INSTALL_DIR="/opt/cni/bin"

curl -LO "https://github.com/containernetworking/plugins/releases/download/$CNI_PLUGIN_VERSION/$CNI_PLUGIN_TAR"
mkdir -p "$CNI_PLUGIN_INSTALL_DIR"
tar -xf "$CNI_PLUGIN_TAR" -C "$CNI_PLUGIN_INSTALL_DIR"
rm "$CNI_PLUGIN_TAR"

### User ~/.profile
sudo -u vagrant -i << '_EOF'
cat >> ~/.profile << '_EOF_EOF'

# set PATH so it includes arkade bin's if they exist
if [ -d "$HOME/.arkade/bin" ] ; then
    PATH="$PATH:$HOME/.arkade/bin"
fi
_EOF_EOF

### Install ark's bins
source ~/.profile
arkade get kubectl minikube
_EOF

cp /home/vagrant/.arkade/bin/kubectl /usr/local/bin/
cp /home/vagrant/.arkade/bin/minikube /usr/local/bin/
