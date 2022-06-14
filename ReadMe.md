# Borg Backup Admin Server Entity(BorgBASE)
## Description
A containerized Borg backup server running over a reverse SSH tunnel. Built for Docker/Kubernetes.
Currently only serves 1 remote backup host at a time.

## Note
- This project is production ready. However, you may want to add additional restrictions to `app/sshd_config`.
- The backup repo is restricted to `/backups/<my_repo_name>`.

## Installation
Clone the repo and build the image:
```bash
git clone https://github.com/vaughngx4/borgbase.git
cd borgbase
./build.sh
```

Copy .env.example and make changes(using vi in the example):
```bash
cp .env.example .env
vi .env
```

Initialize the server:
```bash
docker run --rm -v "/path/to/borg/data/ssh:/data/ssh" --entrypoint "/init.sh" sintelli/borgbase:latest
```
This will return a public key that you will need to authorize on your remote server in order for the server to create a reverse SSH tunnel.

Once authorized, run the container using:
```bash
docker-compose up -d
```
OR if you're using the compose plugin for Docker:
```bash
docker compose up -d
```

That's it! A reverse SSH tunnel to your remote backup location should be up and running for Borg to connnect to. View logs using `docker logs borgbase`

## Development
### ToDo
[ ] Add support for more than 1 repo/machine
[ ] Add web interface for administration
