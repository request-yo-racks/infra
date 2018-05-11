# Deploying onto Kubernetes

## Creating the cluster

This was done via the web UI.

## Creating the node pool

```bash
gcloud container node-pools create "pool-2-standard" \
  --cluster "ryr-prod" \
  --enable-autorepair \
  --enable-autoupgrade \
  --zone=us-central1-a \
  --max-nodes=6 \
  --min-nodes=3 \
  --machine-type=n1-standard-1 \
  --scopes "https://www.googleapis.com/auth/ndev.clouddns.readwrite"
```

### Migrating

In case you mess something up and have to recreate your node-pool...

```bash
gcloud container node-pools list --cluster ryr-prod
for node in $(kubectl get nodes -l cloud.google.com/gke-nodepool=pool-1-standard -o=name); do kubectl cordon "$node"; done
for node in $(kubectl get nodes -l cloud.google.com/gke-nodepool=pool-1-standard -o=name); do kubectl drain --force --ignore-daemonsets --delete-local-data --grace-period=10 "$node"; done
gcloud container node-pools delete pool-1-standard --cluster ryr-prod
```

link: <https://cloud.google.com/kubernetes-engine/docs/tutorials/migrating-node-pool>

## Setting up helm

### RBAC

Then run:
```bash
kubectl create -f helm-rbac-config.yaml
helm init --service-account tiller
```

link: <https://github.com/kubernetes/helm/blob/master/docs/rbac.md>

## Setup the nginx ingress controller

GKE offers a L7 ingress controller out of the box, but I prefer to use the nginx-ingress controller to avoid creating
extra resources.

```bash
helm install --name nginx-ingress stable/nginx-ingress -f nginx-controller.values.yaml
```

* link: <https://cloud.google.com/community/tutorials/nginx-ingress-gke>

## Setup the external DNS for GCE

```bash
helm install --name external-dns -f external-dns.values.yaml stable/external-dns
```

* link: <https://github.com/kubernetes-incubator/external-dns/blob/master/docs/tutorials/gke.md>
* [Wrong DNS entries](https://github.com/kubernetes-incubator/external-dns/issues/223)
* [DNS troubleshooting](https://developers.google.com/speed/public-dns/docs/troubleshooting)

## Test the Setup

```bash
kubectl create -f external-dns-sample-app.yaml
```

Wait for about 2 minutes.

```bash
# Test the DNS
dig @8.8.8.8  via-ingress.requestyoracks.org

# Test the service
curl via-ingress.requestyoracks.org
```

### Clean up the test

```bash
kubectl delete -f external-dns-sample-app.yaml
```

## HTTPS certificates with Let's Encrypt

Install cert-manager:
```bash
helm install --name cert-manager --namespace kube-system stable/cert-manager
kubectl apply -f letsencrypt-cluster-issuer.yaml
kubectl apply -f letsencrypt-certificate.yaml
```

links:
* <https://github.com/ahmetb/gke-letsencrypt>
* <https://cert-manager.readthedocs.io/en/latest/reference/issuers.html>
* <https://cert-manager.readthedocs.io/en/latest/reference/ingress-shim.html>


## Prepare the secrets

Add the following files to `~/.config/ryr/kubernetes-secrets`:
* redis-password
* DJANGO_SECRET_KEY
* DJANGO_ALLOWED_HOSTS

Follow the same steps ass the ones described in the setup guide.
