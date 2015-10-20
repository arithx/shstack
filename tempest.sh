cd /opt/stack/new/tempest
testr init
testr run (?!.*\[.*\bslow\b.*\])(^tempest\.(api|scenario|thirdparty)) --subunit | subunit-trace --nofailure-debug -f
subunit2html /opt/stack/new/tempest/.testrepository/0 /opt/stack/new/tempest/results.html
pip install junitxml
subunit2junitxml /opt/stack/new/tempest/.testrepository/0 > /opt/stack/new/tempest/junit.xml
