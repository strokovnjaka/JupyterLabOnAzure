# Use case JupyterLabOnAzure: a server with jupyter lab on Azure with terraform

Use case for putting jupyter lab server with git repo support on Azure with terraform/ansible.

## Build the image

Prepare `credentials/id_rsa.pub` public key file to enable ssh connection to VM from your own system (as well as from container via ssh auth socket forwarding, see below).

```bash
docker build --file Dockerfile --tag=strokovnjaka/uc1jupyterlab --build-arg TERRAFORM_VERSION=1.0.11 .
```

## Test image

### Run container

Prepare `credentials/azure.env` (e.g. from the template file `credentials/azure.env.tmpl`).

On MacOSX use the following for correct ssh auth socket forwarding:

```bash
docker run -itd --rm -v /run/host-services/ssh-auth.sock:/run/host-services/ssh-auth.sock -e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock" --env-file "credentials/azure.env" --name uc1jupylab strokovnjaka/uc1jupyterlab
```

On other systems probably something like: 

```bash
docker run -itd --rm -v $(dirname $SSH_AUTH_SOCK) -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK --env-file "credentials/azure.env" --name uc1jupylab strokovnjaka/uc1jupyterlab
```

### Step into container

```bash
docker exec -it uc1jupylab /bin/bash
```

### Run terraform in container

Variables that can be passed e.g. via `terraform.tfvars` (see the `vps/terraform.tfvars.tmpl` template):

- `port` instance's port
- `clients` list of allowed IPs
- `gitrepo` git repo address, https accessible
- `gituser` git repo username
- `gitpass` git repo access token (password not recommended)

Then initialize terraform and apply the plan:

```bash
terraform init
terraform apply
```

Outputs are `public_ip`, `port`, and `token`.
Go to `[public_ip]:[port]` in your browser to see results. Use the `token` for first login. Note that you have to choose `File` -> `Shut Down` and wait ~10s for the jupyter server to restart if you choose to use password instead of token.

## Push image to Docker Hub

In case you want to push the image to the hub:

```bash
docker push strokovnjaka/uc1jupyterlab
```