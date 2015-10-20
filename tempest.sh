cd /opt/stack/new/tempest
testr init
<<<<<<< HEAD
testr run (?!.*\[.*\bslow\b.*\])(^tempest\.(api|scenario|thirdparty)) --subunit | subunit-trace --nofailure-debug -f
=======
testr run tempest.api.compute --subunit | subunit-trace --no-failure-debug -f
>>>>>>> bd63fafc8c1d5201bc725a4ebbcf885a591f9db9
subunit2html /opt/stack/new/tempest/.testrepository/0 /opt/stack/new/tempest/results.html
