# Two Sum API deployed in K8s

This is a solution of [Two Sum](https://leetcode.com/problems/two-sum/description/) leetcode problem implemented with Flask as an API and deployed to Minikube (Kubernetes) cluster in Vagrant.

## Description

We have two solutions of the same problem here — the first one (`app/proper_solution.py`) is an optimal solution, and the second one (`app/fallback_solution.py`) is a simple solution. The optimal solution is deployed as a default solution, and the second solution is a fallback — if something's wrong with the default solution, all requests to the app would go to the second solution.

So, we have two Dockerfiles, two Kubernetes services and two deployments here: the main deployment (`k8s/deployment.proper.yaml`) uses image built from `app/Dockerfile.proper`, and the fallback deployment(`k8s/deployment.fallback.yaml`) uses image build from `app/Dockerfile.fallback`. Both apps have a healthcheck endpoint, and healthchecks are also added to both deployments.

The app is exposed via `k8s/ingress.yaml`, and both services are added to this ingress as backends. All requests to ingress are proxied to the first service by default — but, if the first service fails its healthcheck, ingress would start proxying requests to the second (fallback) service.
