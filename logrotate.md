Set up logrotate
```
sudo apt update
sudo apt install logrotate

logrotate --version
```

Configuration file: `sudo vim /etc/logrotate.d/rails_app`
```
/var/www/ycurve-rails/release/log/*.log {
  monthly
  missingok
  rotate 12
  compress
  delaycompress
  notifempty
  copytruncate
}
```
daily rotates logs every day. (I set to monthly in this case)
missingok ignores missing log files.
rotate 7 keeps seven days of logs before deletion.
compress and delaycompress reduce disk usage.
notifempty skips rotation if the log is empty.
copytruncate safely rotates an active log file without restarting Rails.


```
# Dry run to test
sudo logrotate /etc/logrotate.conf -d

# Force rotation immediately
sudo logrotate /etc/logrotate.conf --force

# Confirm logrotate timer is running
systemctl status logrotate.timer
```