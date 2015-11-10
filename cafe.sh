apt-get update && apt-get install -y git openssh-server wget python-dev make build-essential puppet

wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py

git clone https://github.com/stackforge/opencafe.git && pip install ./opencafe
git clone https://github.com/stackforge/cloudcafe.git && pip install ./cloudcafe
git clone https://github.com/stackforge/cloudroast.git && pip install ./cloudroast
git clone https://github.com/openstack/syntribos.git && pip install ./syntribos

cafe-config plugins install http
cafe-config plugins install ssh
cafe-config plugins install winrm
cafe-config plugins install subunit

wget https://raw.github.com/arithx/shstack/master/devstack.config -P /root/.opencafe/configs/compute

cafe-runner compute devstack --result subunit --result-directory /root/
