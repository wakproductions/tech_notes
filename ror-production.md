# Production Server NGINX Reverse Proxy Setup With RoR Apps Running on Docker

Prereq:
1. Install NGINX using apt-get (https://www.nginx.com/resources/wiki/start/topics/tutorials/install/)
2. Install Docker
3. Install Docker-compose

### sudo: no tty present and no askpass program specified
https://stackoverflow.com/questions/21659637/how-to-fix-sudo-no-tty-present-and-no-askpass-program-specified-error
https://www.tecmint.com/run-sudo-command-without-password-linux/

```
sudo visudo

# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL
deploy_user ALL=(ALL) NOPASSWD: /usr/local/bin/docker-compose

```
  

```
# /etc/nginx/conf.d/ustreasuryyieldcurve.com

server {
  listen 80;
  // listen 443 ssl;
  server_name ustreasuryyieldcurve.com;

  location / {
    proxy_pass http://localhost:3030/;
    proxy_buffering off;
  }
}
```

Then `sudo service nginx restart`

### Set up the Capistrano dir

* Create the base folder and linked files - .env especially
* 

### Set up Let's Encrypt

1. Install certbot (https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal)

Snapd needs to be installed first
```
$ sudo snap install --classic certbot
$ sudo ln -s /snap/bin/certbot /usr/bin/certbot
$ sudo certbot --nginx
```

2. Run certbot
sudo certbot --nginx -d ustreasuryyieldcurve.com -d www.ustreasuryyieldcurve.com

Crontab for renewal:
sudo crontab -e
* 2 * * 7 /opt/letsencrypt/letsencrypt-auto renew >> /var/log/le-renew.logmixed
This will automatically renew the SSL certificate at 2AM every Sunday. (not the right command - gotta update)

## Nokogiri Install Problems

`gem install nokogiri -- --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include/libxml2 --use-system-libraries` 