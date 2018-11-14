import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_user(host):
    user = host.user("divona")
    assert user.exists
    assert user.shell == "/bin/bash"

def _check_directory(directory, name):
    assert directory.exists
    assert directory.is_directory
    assert directory.user == name
    assert directory.group == name


def test_applications_directory(host):
    apps_dir = host.file('/home/divona/Apps')
    _check_directory(apps_dir, "divona")


def test_user_binaries_directory(host):
    bin_dir = host.file('/home/divona/bin')
    _check_directory(bin_dir, "divona")
