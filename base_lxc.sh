if [ ! -e "/usr/bin/git" ]; then
    apt-get install -qqy git
fi

apt-get update
apt-get -qqy install git socat curl sudo vim wget net-tools git socat curl sudo vim wget net-tools libffi-dev libkrb5-dev libev-dev libvirt-dev libsqlite3-dev libxml2-dev libxslt-dev libpq-dev libssl-dev libyaml-dev make build-essential python-dev libffi-dev libssl-dev

git clone https://github.com/openstack-dev/devstack
devstack/tools/create-stack-user.sh
wget https://raw.github.com/arithx/shstack/master/stack_setup_lxc.sh -P /tmp
chmod +755 /tmp/stack_setup_lxc.sh
sudo -H -u stack /tmp/stack_setup_lxc.sh
wget https://raw.github.com/arithx/shstack/master/tempest.sh -P /tmp
chmod +755 /tmp/tempest.sh
sudo -H -u stack /tmp/tempest.sh
tar -zcvf /opt/stack/new/nova_logs.tar.gz /opt/stack/new/n-*
