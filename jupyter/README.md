# jupyter
[Minimal Jupyter Notebook Stack](https://github.com/jupyter/docker-stacks)

## Control the container:
- `docker-compose up` mounts the directory and starts the container
- `docker-compose down` destroys the container

### Example
``` bash
cd /go/to/dockerfiles/jupyter
mkdir work
chown 1000:1000 work
docker-compose up -d

# This is optional.
# Create virtual enivronment of Python 3.6
docker exec --user jovyan jupyter_notebook /home/jovyan/work/init.sh
```

## The environment file: .env
``` bash
# Define a local data directory
# Set permissions for the container:
# sudo chown -R 1000 ${LOCAL_WORKING_DIR}
# or sudo chown -R $(id -u) ${LOCAL_WORKING_DIR}
# or sudo chown -R $(id -u):$(id -g) ${LOCAL_WORKING_DIR}
NB_UID=1000
NB_GID=1000

# Bind mount, ${LOCAL_WORKING_DIR}:/home/jovyan/work
LOCAL_WORKING_DIR=./work

# Generate an access token like this
#   import IPython as IPython
#   hash = IPython.lib.passwd("mypassword")
#   print(hash)
# You can use the script generate_token.py

ACCESS_TOKEN=sha1:629fd82c07cd:18656739b4435a6acbd55c7fb4b20939c33f5829

# Host port
PORT=8888

# SSL
# Generate cert like this:
#   openssl req -x509 -nodes -newkey rsa:2048 -keyout jupyter.pem -out jupyter.pem
# Copy the jupyter.pem file into the location below.
#LOCAL_SSL_CERTS=/opt/ssl-certs/jupyter
```

## The compose file: docker-compose.yml
``` yaml
version: '3'
services:
  notebook:
    image: jupyter/minimal-notebook
    volumes:
      - ${LOCAL_WORKING_DIR}:/home/jovyan/work
    #  - ${LOCAL_SSL_CERTS}:/etc/ssl/notebook
    environment:
      - NB_UID=${NB_UID}
      - NB_GID=${NB_GID}
    user: root
    ports:
      - ${PORT}:8888
    container_name: jupyter_notebook
    command: [ "start-notebook.sh"
              ,"--NotebookApp.password=${ACCESS_TOKEN}"
              ,"--NotebookApp.notebook_dir=/home/jovyan/work"
              #,"--NotebookApp.certfile=/etc/ssl/notebook/jupyter.pem"
             ]
    # jupyter lab command
    #command: [ "start.sh", "jupyter", "lab"
    #          ,"--NotebookApp.password=${ACCESS_TOKEN}"
    #          ,"--NotebookApp.notebook_dir=/home/jovyan/work"
    #          #,"--NotebookApp.certfile=/etc/ssl/notebook/jupyter.pem"
    #         ]
```
