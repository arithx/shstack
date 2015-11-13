apt-get update && apt-get install -y git openssh-server wget python-dev make build-essential puppet

wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py

# Syntribos requires opencafe but installs an older version
# We just use it for a library workaround currently
# Make sure that this is installed first and upgraded over later
git clone https://github.com/openstack/syntribos.git && pip install ./syntribos

# Pulling a specific review head until it is merged which provides subunit results
git clone https://github.com/stackforge/opencafe.git
cd opencafe
git fetch https://review.openstack.org/openstack/opencafe refs/changes/32/241732/12 && git checkout FETCH_HEAD
pip install . --upgrade
cd ..

git clone https://github.com/stackforge/cloudcafe.git && pip install ./cloudcafe
git clone https://github.com/stackforge/cloudroast.git && pip install ./cloudroast

# When installing opencafe from a source you must run all of the initial setups manually
cafe-config engine --init-install

# Again, this is not taken care of when installing from a source
cp -r opencafe/cafe/plugins/* /root/.opencafe/plugin_cache

# Install the required plugins for compute & the subunit plugin
cafe-config plugins install http
cafe-config plugins install ssh
cafe-config plugins install winrm
cafe-config plugins install subunit

# Pull our custom version of the compute devstack config
wget https://raw.github.com/arithx/shstack/master/cafe_devstack.config -P /root/.opencafe/configs/compute

# Source the openrc and then pull IDs from the nova client to update the config
source /opt/stack/devstack/openrc
image_id=$(nova image-show cirros-0.3.4-x86_64-uec | egrep "id" | egrep -v "_id" | egrep "([[:alnum:]]+-?){5}" -o)
flavor_id1=$(nova flavor-show m1.nano | egrep "id" | egrep [0-9]* -o)
flavor_id2=$(nova flavor-show m1.micro | egrep "id" | egrep [0-9]* -o)
sed -rie "s/<image_id>/$image_id/" /root/.opencafe/configs/compute/cafe_devstack.config
sed -rie "s/<flavor_id1>/$flavor_id1/" /root/.opencafe/configs/compute/cafe_devstack.config
sed -rie "s/<flavor_id2>/$flavor_id2/" /root/.opencafe/configs/compute/cafe_devstack.config

cafe-runner compute cafe_devstack --result subunit --result-directory /root/
