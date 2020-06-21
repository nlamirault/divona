import abc
import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


class Distribution(abc.ABC):

    @abc.abstractmethod
    def check_editors(self, host):
        pass

    def check_package_installed(self, host, packages):
        for pkg in packages:
            assert host.package(pkg).is_installed

    def check_directory_exists(self, host, name):
        host.file("/home/divona/Applications/VSCode-linux-x64/").is_directory


class Archlinux(Distribution):

    def check_editors(self, host):
        self.check_package_installed(host, ["emacs"])
        self.check_package_installed(host, ["neovim"])
        self.check_directory_exists(
            host, "/home/divona/Applications/VSCode-linux-x64/")


class Debian(Distribution):

    def check_editors(self, host):
        self.check_package_installed(host, ["emacs"])
        self.check_package_installed(host, ["neovim"])
        self.check_directory_exists(
            host, "/home/divona/Applications/VSCode-linux-x64/")


class Centos(Distribution):

    def check_editors(self, host):
        self.check_package_installed(host, ["emacs"])
        self.check_package_installed(host, ["neovim"])
        self.check_directory_exists(
            host, "/home/divona/Applications/VSCode-linux-x64/")


class Fedora(Distribution):

    def check_editors(self, host):
        self.check_package_installed(host, ["emacs"])
        self.check_package_installed(host, [
            "neovim", "python2-neovim", "python3-neovim"])
        self.check_directory_exists(
            host, "/home/divona/Applications/VSCode-linux-x64/")


def _create_distribution(name):
    platform = None
    if name == "archlinux":
        platform = Archlinux()
    elif name == "debian":
        platform = Debian()
    elif name == "centos":
        platform = Centos()
    elif name == "fedora":
        platform = Fedora()
    return platform


def test_editors(host):
    distribution = _create_distribution(host.system_info.distribution)
    if distribution:
        distribution.check_editors(host)
