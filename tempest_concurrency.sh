cd /opt/stack/new/tempest
testr init
testr run '(?!.*\[.*\bslow\b.*\])(^tempest\.(api|scenario|thirdparty))' --concurrency=4 --subunit | subunit-trace --no-failure-debug -f
subunit2html /opt/stack/new/tempest/.testrepository/0 /opt/stack/new/tempest/results.html
