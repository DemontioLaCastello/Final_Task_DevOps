# Sync the script into the VM
rsync -a /vagrant/app /home/vagrant/
rsync -a /vagrant/k8s /home/vagrant/

# Start Minikube
minikube start --driver=none

# Build solutions
cd /home/vagrant/app

docker build -t fallback-solution -f Dockerfile.fallback .
docker build -t proper-solution -f Dockerfile.proper .

cd /home/vagrant/k8s

minikube addons enable ingress

kubectl apply -f deployment.proper.yaml
kubectl apply -f deployment.fallback.yaml
kubectl apply -f ingress.yaml