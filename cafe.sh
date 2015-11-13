apt-get update && apt-get install -y git openssh-server wget python-dev make build-essential puppet

wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py

git clone https://github.com/openstack/syntribos.git && pip install ./syntribos

git clone https://github.com/stackforge/opencafe.git
cd opencafe
git fetch https://review.openstack.org/openstack/opencafe refs/changes/32/241732/12 && git checkout FETCH_HEAD
pip install . --upgrade
cd ..

git clone https://github.com/stackforge/cloudcafe.git
cd cloudcafe
git fetch https://review.openstack.org/openstack/cloudcafe refs/changes/47/243747/1 && git checkout FETCH_HEAD
pip install .
cd ..

git clone https://github.com/stackforge/cloudroast.git && pip install ./cloudroast

cafe-config engine --init-install

cp -r opencafe/cafe/plugins/* /root/test/.opencafe/plugin_cache

cafe-config plugins install http
cafe-config plugins install ssh
cafe-config plugins install winrm
cafe-config plugins install subunit

wget https://raw.github.com/arithx/shstack/master/cafe_devstack.config -P /root/test/.opencafe/configs/compute

cafe-runner compute cafe_devstack --result subunit --result-directory /root/
