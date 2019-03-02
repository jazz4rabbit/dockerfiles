# latex 
Ubuntu 18.04 with Latex

## docker-compose.yml
```yaml
version: '3'
services:
  notebook:
    image: jazz4rabbit/latex
    volumes:
      - ./work:/home/jovyan/work
```

## up and running
```bash
docker-compose up -d
```
