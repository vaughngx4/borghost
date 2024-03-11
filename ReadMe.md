# BorgHost (Borg Host)
## Description
A containerized Borg backup server running over a reverse SSH tunnel.

This image is used by [BorgBaSE](https://github.com/vaughngx4/borgbase) to serve repositories.

## Note
- This image is production ready. However, you may want to add additional restrictions to `app/sshd_config`.
- The backup repository is restricted to the `$REPO` variable set in the env file.

## Installation
Clone source and build the image:
```bash
git clone https://github.com/vaughngx4/borghost.git
cd borghost
./build.sh
```

Copy .env.example and make changes:
```bash
cp .env.example .env
$EDITOR .env
```

Initialize the server:
```bash
docker run --rm -v "/path/to/borg/data/ssh:/data/ssh" --entrypoint "/init.sh" sintelli/borghost:latest
```
This will return a public key that you will need to authorize on your remote server in order for BorgHost to connect via SSH.

Once authorized, run the container using:
```bash
docker compose up -d
```

That's it! A reverse SSH tunnel to your remote backup location should be up and running for Borg to connnect to. View logs using `docker logs borghost`

## Contact Us
You can get a hold of us on [Discord](https://discord.gg/TSnvnjE6zP) or [send us a message](https://sintelli-tech.com/contact) 
