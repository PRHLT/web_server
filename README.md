# Web server
This repository contains all the scripts and info to run the [PRHLT](https://www.prhlt.upv.es/)'s web server and its member's personal web spaces (https://www.prhlt.upv.es/~username).

## Nginx configuration
The web server is based on Nginx running trhough docker-compose. It is expected to be located in a `nginx` folder at the home's directory of a user named `webmaster`.

### SSL
Prior to running the Nginx server, you need to place the following files into your `nginx` directory:

* certificado.pem.
* certificado.key.
* dhparam2048.pem.

where `certificado.pem` and `certificado.key` are your SSL certificate files; and `dhparam2048.pem` is obtained by running the following command:

```
openssl dhparam -outform pem -out dhparam2048.pem 2048
```

### Run
You can run the Nginx server by doing:

```
docker-compose up -d
```

Note: you need to run this command inside the `/home/webmaster/nginx` directory.

## Personal spaces
The Nginx server is prepared to run personal web pages for the PRHLT's members (https://www.prhlt.upv.es/~username). However, access is not granted by default. You can grant access to a user by running the `scr/personal_spaces.sh` script:

```
sudo scr/personal_spaces.sh username
```

Besides granting the user access, it will create a `public_html` folder inside their home directory. They can create their own personal website inside that folder.

### Back-up
`scr/personal_spaces_backup.sh` constains a script for saving a back-up of the personal spaces. To set it up, you just need to edit the variables `username` and `server` with the data of your back-up server and programe a daemon with root permissions:

```
sudo crontab -e
```

Here's an example of a configuration:

```
0 0 * * * /home/webmaster/scr/personal_spaces_backup.sh
```

## PRHLT web
The [PRHLT](https://www.prhlt.upv.es/) web run's through a separate docker which has an Apache server. The Nginx server it's set up to proxy pass petitions to it through port 8000.
