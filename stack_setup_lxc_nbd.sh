cd ~
git clone https://github.com/openstack-dev/devstack
cd devstack
wget https://raw.github.com/arithx/shstack/master/localrc_lxc_nbd -O localrc
chmod +755 stack.sh
./stack.sh