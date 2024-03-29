# Linux Cheat Sheet

## Winston's New Server Setup Process ##
* Create winston user as an admin so you don't have to use root
* Create new user (i.e. deploy)
* SSH key for deploy from Github on deploy user
* Add login SSH key
* Set up terminal scripts on new user (.bashrc) - usually can skip this
* Install Docker
  - Configure docker to run without sudo required https://docs.docker.com/engine/install/linux-postinstall/
  - Install networks and volumes 
* Install NGINX
  - https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04
  - Note, not using UFW because iptables is sufficient

## User Management Process Crash Course
https://www.youtube.com/watch?v=19WOD84JFxA

* See existing users on the system: `cat /etc/passwd`
  - Use `wc`  to get number of users by lines `cat /etc/passwd | wc -l`
  - User IDs below 1000 are system accounts
* Create users `sudo useradd <user>`


## Command line shortcuts ##

[Bash Shortcuts](https://www.howtogeek.com/howto/ubuntu/keyboard-shortcuts-for-bash-command-shell-for-ubuntu-debian-suse-redhat-linux-etc/#:~:text=Ctrl%2BL%3A%20Clear%20the%20screen,command%20itself%20with%20Ctrl%2BC.)

* `Ctrl + L` - clear the screen
* `Ctrl + S` / `Ctrl + Q` - stop/resume output to the screen

Navigating words/lines
* `Ctrl + A` - go to beginning of line
* `Ctrl + E` - go to end of line
* `Ctrl + F` / `Alt + F` - move forward/back one word
* `Alt + D` - remove all characters after the cursor on current line

Clipboard
* `Ctrl + W` - cut word before cursor and add to clipboard
* `Ctrl + K` - Cut line after cursor
* `Ctrl + U` - Cut line before cursor
* `Ctrl + Y` - Paste


## Setting Up a New Server ##

https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04

When you set up an initial instance of Linux, there's a default user (usually `root`) under which you can log in using
an initial password. Steps to setup:

1. Change root password
```
sudo passwd root
```

2. Create new user for login with root privileges. -aG sudo appends the group sudo to <newuser> making it a superuser

```
adduser <newuser>
usermod -aG sudo <newuser>
```

(To create a home dir and login profile for that user you can do, without -p you can set password `sudo passwd <username>`)
```
sudo useradd -m <username> -p <password>
```

To view users in group:
```
grep <groupname> /etc/group
```

You can create a new group by doing `sudo groupadd <groupname>`

3. Create a user for running applications (not with sudo privileges)
4. Install public key for logging on
```
(on local machine)
cat ~/.ssh/id_rsa.pub

(on remote machine as root)
mkdir ~/.ssh
chmod 700 ~/.ssh
vim ~/.ssh/authorized_keys

<paste the key>
```


5. Firewall setup 

6. Disable Apache

Apache was enabled by default on the server I created. To disable from booting.
```
sudo update-rc.d apache2 disable

or

sudo update-rc.d -f  apache2 remove
```

https://askubuntu.com/questions/170640/how-to-disable-apache2-server-from-auto-starting-on-boot

> Under the folder /etc/init.d/ you will find all the init scripts for different boot up services, like apache2, networking, etc.
>
> Depending on which runlevel the computer starts in, different services are started. So from the /etc/init.d/ folder each "service" is linked to one/many/no run level folders named from rc0.d to rc6.d

To just stop Apache:
```
sudo systemctl stop apache2.service
```

## Configure docker to run without sudo required ##
https://docs.docker.com/engine/install/linux-postinstall/

```
sudo groupadd docker
sudo usermod -aG docker $USER
sudo usermod -aG docker <desired users>
```

log out and log back in to initialize new group membership

verify you can run docker without sudo
```
docker run hello-world
```

If you receive this error `WARNING: Error loading config file: /home/user/.docker/config.json -
stat /home/user/.docker/config.json: permission denied`, you may have to run:

You may have to give permission to the `~/.docker` directory by running:
```
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
```


## Check Linux Version

Debian (any of the following):
```
cat /etc/issue
cat /etc/debain_version
cat /etc/os-release
```



### Install NGINX to proxy SSL

https://mediatemple.net/community/products/developer/204405534/install-nginx-on-ubuntu
```
sudo apt-get nginx
sudo /etc/init.d/nginx start
```

## User Management ##

### Group Management

Add existing user tony to ftp supplementary/secondary group with the usermod command using the -a option ~ i.e. add the user to the supplemental group(s). Use only with -G option:
```
usermod -a -G ftp tony
```

In this example, change tony user’s primary group to www, enter:
```
usermod -g www tony
```

#### On Mac

Delete user from group
```
sudo dseditgroup -o edit -d $username -t user $groupname
```

Add user to group
```
sudo dseditgroup -o edit -a $username -t user $groupname
```

List members in group
```
dscacheutil -q group -a name _www 
```

List groups of user
```
id -Gn  $username
```


### Switch to Root

```
sudo -s

or

su -
```

## File Operations ##

### Permissions with `chmod` & `chown`
chmod: 1=x, 2=w, 4=r

chmod (user)(group)(other)
chmod 730 # only the user can rwx, read permission to the group or other

chown owner:group file

```
     chmod u=rx file        (Give the owner rx permissions, not w)
     chmod go-rwx file      (Deny rwx permission for group, others)
     chmod g+w file         (Give write permission to the group)
     chmod a+x file1 file2  (Give execute permission to everybody)
     chmod g+rx,o+x file    (OK to combine like this with a comma)
```

### Create a file with text

```
delta-ironhammer-rails (develop)$ echo 2.4.1 | cat > .ruby-version
delta-ironhammer-rails (develop)$ cat .ruby-version
2.4.1

```

### Truncate File

```
truncate -s 0 myfile.txt
```

### Search for text

[How to search text files for specific text](http://stackoverflow.com/questions/16956810/how-to-find-all-files-containing-specific-text-on-linux)

```
grep -rnw '/path/to/somewhere/' -e "pattern"
```

### Search for file

`find /dir/path/look/up -name "pattern"`

To search a compressed text file, use `zgrep`

```zgrep a7505707-1224-483b-93f9-aa150175fd8b *```

### Tail a log file


Tail in follow mode (`-f`) for 50 lines
```
tail -f -n 50
```

### Symbolic links `ln`

Create symbolic link:
```
ln -s [TARGET DIRECTORY OR FILE] ./[SHORTCUT]

-sfv switch commonly used:
-b, --backup[=Control]: Backup each existing destination file

-d, -F, --directory: Hard link directories (super-user only)
-f, --Force: Remove existing destination file(s)
-n, --no-dereference: Treat destination that is a symlink to a directory as if it were a normal file.
-i, --interactive: Prompt whether to remove destinations
-s, --symbolic: Make symbolic links instead of hard links -S [suffix], --suffix=[Suffix]: Override the usual backup suffix. See below
-target-directory=[directory]: Specify the directory in which to create the links.
-v, --verbose: Print name of each file before linking.
```

## Copy file remotely using `scp`

```
scp <file_source> <file_dest>
scp /mnt/mysql/dump/fi_app_metadata.sql ~/Development/fi_app_metadata.sql
```

To get a file from remote to local (from local terminal):
```
$ scp ubuntu@fidb-staging:/mnt/mysql/dump/*_20170320.sql /Users/wkotzan/Development/
banks_20170320.sql                                                                                                                          100% 2035KB   2.0MB/s   00:01    
sites_20170320.sql                                                                                                                          100% 4458KB   2.2MB/s   00:02 
```

## Compression ##

Compress file
```
tar -czvf --exclude<pattern> myfile.tar.gz /path/to/directory
```

See what's in tar
```
tar -tvf myfile.tar.gz
```

Extract
```
tar -xf myfile.tar.gz
```


## Disk Operations ##

### Get Disk Space Usage - size

[Find the size of a given subdirectory.](http://unix.stackexchange.com/questions/185764/how-do-i-get-the-size-of-a-directory-on-the-command-line)
[Using du to find troublesome directories](http://unix.stackexchange.com/questions/125429/tracking-down-where-disk-space-has-gone-on-linux
```
$ du -sh app
120K	app
$ du -sh log
 82M	log
 
$ du -sh * 
 
```
```
$ ncdu
```
```
Development$ du -mh ./ | sort -nr | head -n 20
1004K	.//telnyx_omega_pricing/deps/idna/src
968K	.//telnyx_omega_pricing/node_modules/babel-runtime
920K	.//telnyx_omega_pricing/deps/cowboy
916K	.//telnyx_omega_pricing/deps/ecto/lib
916K	.//ksm_consulting_sql/deps/ecto
880K	.//telnyx_omega_pricing/_build/test/lib/postgrex
880K	.//telnyx_omega_pricing/_build/dev/lib/postgrex
879M	.//regdata/log
856K	.//telnyx_omega_pricing/_build/test/lib/postgrex/ebin
856K	.//telnyx_omega_pricing/_build/dev/lib/postgrex/ebin
848K	.//telnyx_omega_pricing/deps/ecto/lib/ecto
844K	.//telnyx_omega_pricing/_build/test/lib/phoenix
844K	.//telnyx_omega_pricing/_build/dev/lib/phoenix
844K	.//stock_trend_finder/tmp/cache/assets/development/sass/9bbc4a709c49c4730b532bd57984d33d03c90ee4
844K	.//stock_trend_finder/tmp/cache/assets/development/sass/50b9864b5cefbea17955e7430fab95f1f478681a
844K	.//stock_trend_finder/tmp/cache/assets/development/sass/0db7b347458fb0c41e1987d6ef712ea64ddeb0de
844K	.//regdata/.git/objects/0a
836K	.//stock_trend_finder/tmp/cache/assets/development/sass/d95b5980363d60d8ce51dfb4512674db9ea2beb4
836K	.//stock_trend_finder/.git/objects/ae


Development$ du -sh ./* | sort -nr
340K	./ystock
280K	./telnyx_omega_pricing_rails
120K	./stocktwits-api-ruby
 71M	./telnyx_omega_pricing
 37M	./tdameritrade_api
 34M	./pricemap
6.5M	./ksm_consulting_sql
2.1G	./stock_trend_finder

```

Alternative method:
```
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev             32G  8.0K   32G   1% /dev
tmpfs           6.3G  416K  6.3G   1% /run
/dev/xvda1      7.8G  6.5G  909M  88% /
none            4.0K     0  4.0K   0% /sys/fs/cgroup
none            5.0M     0  5.0M   0% /run/lock
none             32G     0   32G   0% /run/shm
none            100M     0  100M   0% /run/user
/dev/xvdf       3.9T  2.4T  1.4T  64% /mnt/new
```

### Folder Size

```bash
$ du -sh ./
```


```bash
du -d 1 | sort -n
4       ./Foredettinghelgen
4       ./newitpdesign
12      ./fried-mugshots
44      ./IssueTrackerBlogInterface
52      ./levenstein
900     ./Example-Receipts
1856    ./IssueTrackerProduct
2140    ./ies4linux-2.0.5
4528    ./i18nextract-sa
4796    ./photoresizing
4872    ./pyexcelerator
70392   ./databases
544608  .
```
### Disk drives

`/etc/fstab` - file with the drive mounts

```
$ lsblk
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0  10G  0 disk 
└─xvda1 202:1    0  10G  0 part /
xvdb    202:16   0   3G  0 disk 

$ sudo file -s /dev/xvdb
/dev/xvdb: data
```
[If the output of the previous command shows simply data for the device, then there is no file system on the device and you need to create one. You can go on to Step 4. If you run this command on a device that contains a file system, then your output will be different](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html)

```
$ sudo mkfs -t ext4 /dev/xvdb
$ sudo mount /dev/xvdb /pgdata
```

### Find files containing text

`find /etc -type f -print | xargs grep "DocumentRoot"`


## Processes ##

## View all background tasks
```
ps -ef
ps -ax | grep <application name>
```

### Kill Process By Name (Linux)
```
pkill -f processname
```

### Kill Process (Mac)
```
kill -9 <pid>
```


## Network Operations ##

### Netcat

Echo curl request header & body without sending it?
```
nc -l localhost 8000
```

### Get network stats using `nstat`

https://loicpefferkorn.net/2016/03/linux-network-metrics-why-you-should-use-nstat-instead-of-netstat/

Port scan using `nmap`

`nmap <hostname>`

https://www.digitalocean.com/community/tutorials/how-to-use-nmap-to-scan-for-open-ports-on-your-vps

### [Get the external IP address](https://www.cyberciti.biz/faq/how-to-find-my-public-ip-address-from-command-line-on-a-linux/)

```
dig +short myip.opendns.com @resolver1.opendns.com
-or-
dig TXT +short o-o.myaddr.l.google.com @ns1.google.com
```

### Check ports being listened on

```
PRODUCTION ubuntu@ip-172-30-0-78:~$ netstat -nlt
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 127.0.0.1:5432          0.0.0.0:*               LISTEN     
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp6       0      0 :::3030                 :::*                    LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
```

`netstat -tulpn`

### Port tunneling

[3 methods to SSH tunnel](https://www.howtogeek.com/168145/how-to-use-ssh-tunneling/)

#### Method 1: local port forwarding

```
ssh -L local_port:remote_address:remote_port username@server.com
```

## Services ##

### systemctl

Get list of processes
```
systemctl list-unit-files | grep enabled
```

## IP Tables ##

In a default configuration ports are closed. Need to use `iptables` firewall utility to open the ports.

## Do an operation on loop ##

`for i in `seq 10`; do dc exec backend bundle exec rspec spec/services/calculator_service/calculate_work_order_spec.rb; done`

# awk



## CRLF Correction ##

`dos2unix` and `unix2dos` commands


## Memory Management ##

See how much memory is being utilized:
```
$ free -h
              total        used        free      shared  buff/cache   available
Mem:           50Gi       2.1Gi       2.0Gi       471Mi        46Gi        47Gi
```


# Bash Brackets Reference

https://dev.to/rpalo/bash-brackets-quick-reference-4eh6

# Echo a Timestamp

`echo $(date +'%m/%d/%Y')`


# Cron log file at
`/var/log/syslog`


# WSL Compact Drives

```
Optimize-VHD "C:\Users\Winston Kotzan\AppData\Local\Docker\wsl\data\ext4.vhdx"
Optimize-VHD "C:\Users\Winston Kotzan\AppData\Local\Packages\TheDebianProject.DebianGNULinux_76v4gfsz19hv4\LocalState\ext4.vhdx"
```

# Generate SSH Keys

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
```
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

# Set Linux Time Zone

Change the symlink `/etc/timezone`

```
sudo timedatectl set-timezone America/New_York
date
```


# Ionos

Logical Volume Mapping Explained
https://www.ionos.com/help/server-cloud-infrastructure/server-administration/customise-logical-volume-after-enlarging-the-ssd/logical-volume-manager-lvm-basics/

