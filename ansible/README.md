# Ansible deployment

Manages Kubernetes clusters using Ansible.

## Setup the environment


Simply run the setup:
```bash
make
```

The ansible modules will use the `~/.kube/config` file, so be sure to have a working kubernetes client. You can check
it with the following command:
```bash
kubectl config get-contexts
```

Use `make help` for more details.
