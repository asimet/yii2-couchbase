wget http://packages.couchbase.com/releases/4.6.2/couchbase-server-enterprise_4.6.2-ubuntu14.04_amd64.deb
dpkg-deb -x couchbase-server-enterprise_4.6.2-ubuntu14.04_amd64.deb $HOME
rm couchbase-server-enterprise_4.6.2-ubuntu14.04_amd64.deb
cd $HOME/opt/couchbase
./bin/install/reloc.sh `pwd`
./bin/couchbase-server -- -noinput -detached
sleep 20
./bin/couchbase-cli cluster-init -c 127.0.0.1:8091  --cluster-init-username=Administrator --cluster-init-password=Administrator --cluster-init-port=8091 --cluster-init-ramsize=1024
./bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=test --bucket-type=couchbase --bucket-port=11211 --bucket-ramsize=512  --bucket-replica=1 -u Administrator -p Administrator

apt-get -y install libcouchbase-dev build-essential php-dev zlib1g-dev
pecl install pcs-1.3.3
pecl install igbinary
pecl install couchbase
echo "extension=pcs.so" > /etc/php/7.0/mods-available/pcs.ini
echo "extension=igbinary.so" > /etc/php/7.0/mods-available/igbinary.ini
echo "extension=couchbase.so" > /etc/php/7.0/mods-available/couchbase.ini
