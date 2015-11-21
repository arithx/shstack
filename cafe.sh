apt-get update && apt-get install -y git openssh-server wget python-dev make build-essential puppet

wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py

git clone https://github.com/stackforge/opencafe.git && pip install ./opencafe
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

image_id=$(nova image-list | head -4 | tail -1 | egrep "([[:alnum:]]+-?){5}" -o | head -1)
sed -r -i -e "s/<image_id>/$image_id/" /root/.opencafe/configs/compute/cafe_devstack.config

# TODO: remove temp code
echo $image_id > /root/image_id
echo $(nova image-list) >> /root/image_id


cafe-runner compute cafe_devstack --result subunit --result-directory /root/
tar -zcvf /root/cafe_logs.tar.gz /root/.opencafe/logs/compute/cafe_devstack.config/* /root/.opencafe/configs/compute/cafe_devstack.config /root/image_id
