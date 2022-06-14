# Borg Backup Admin Server Entity(BorgBASE)
## Description
A containerized Borg backup server running over a reverse SSH tunnel.
Currently only serves 1 remote backup host at a time.

## Note
This project is still in development.

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

Finally, run the container using:
```bash
docker-compose up -d
```
OR if you're using the compose plugin for Docker:
```bash
docker compose up -d
```

That's it! A reverse SSH tunnel to your remote backup location should be up and running for Borg to connnect to. The backup repo is restricted to `/backups/<my_repo_name>`.
