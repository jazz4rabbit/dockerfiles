# python-weka-notebook 
Jupyter Notebook with `python-weka-wrapper` library

## docker-compose.yml
```yaml
version: '3'
services:
  notebook:
    image: jazz4rabbit/python-weka-notebook
    user: root
    environment:
      - GRANT_SUDO=${GRANT_SUDO}
    ports:
      - ${PORT}:8888
    volumes:
      - ./work:/home/jovyan/work
    entrypoint:
      - start-notebook.sh
    command: 
      - --NotebookApp.notebook_dir=/home/jovyan/work
      - --NotebookApp.password=${NB_PASSWORD}

```

## .env
```yaml
GRANT_SUDO=yes
NB_PASSWORD=sha1:............:........................................
PORT=8888
```

## up and running
```bash
chown 1000:1000 work
docker-compose up -d
```
