cd /opt/stack/new/tempest
testr init
testr run tempest.api --subunit | subunit-trace --nofailure-debug -f
subunit2html /opt/stack/new/tempest/.testrepository/0 /opt/stack/new/tempest/results.html
