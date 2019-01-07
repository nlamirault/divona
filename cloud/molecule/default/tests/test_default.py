import abc
import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


class Distribution(abc.ABC):

    @abc.abstractmethod
    def check_virtualization_tools(self, host):
        pass

    @abc.abstractmethod
    def check_containers_tools(self, host):
        pass

    def check_hashicorp_tools(self, host):
        self.check_file_exists(host, "/home/divona/bin/packer")
        self.check_file_exists(host, "/home/divona/bin/terraform")
        self.check_file_exists(host, "/home/divona/bin/vault")

    def check_kubernetes_tools(self, host):
        self.check_file_exists(host, "/home/divona/bin/kubectl")
        self.check_file_exists(host, "/home/divona/bin/minikube")

    def check_gcloud_sdk(self, host):
        self.check_file_exists(
            host, "/home/divona/bin/google-clouds-sdk/bin/gcloud")

    def check_package_installed(self, host, packages):
        for pkg in packages:
            assert host.package(pkg).is_installed

    def check_file_exists(self, host, filename):
        host.file(filename).exists


class Archlinux(Distribution):

    def check_virtualization_tools(self, host):
        self.check_package_installed(host, [
            "vagrant", "virtualbox", "qemu"])

    def check_containers_tools(self, host):
        self.check_package_installed(host, ["docker"])


class Centos(Distribution):

    def check_virtualization_tools(self, host):
        pass

    def check_containers_tools(self, host):
        self.check_package_installed(host, ["docker"])


class Fedora(Distribution):

    def check_virtualization_tools(self, host):
        # self.check_package_installed(host, [
        #     "vagrant", "virtualbox"])
        pass

    def check_containers_tools(self, host):
        self.check_package_installed(host, ["docker"])


class Debian(Distribution):

    def check_virtualization_tools(self, host):
        self.check_package_installed(host, [
            "vagrant", "virtualbox-5.2"])

    def check_containers_tools(self, host):
        self.check_package_installed(host, ["docker"])


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


def test_virtualization(host):
    distribution = _create_distribution(host.system_info.distribution)
    if distribution:
        distribution.check_virtualization_tools(host)


def test_hashicorp_tools(host):
    Archlinux().check_hashicorp_tools(host)
    Debian().check_hashicorp_tools(host)
    Centos().check_hashicorp_tools(host)
    Fedora().check_hashicorp_tools(host)


def test_kubernetes_tools(host):
    Archlinux().check_kubernetes_tools(host)
    Debian().check_kubernetes_tools(host)
    Centos().check_kubernetes_tools(host)
    Fedora().check_kubernetes_tools(host)


def test_gcloud_sdk(host):
    Archlinux().check_gcloud_sdk(host)
    Debian().check_gcloud_sdk(host)
    Centos().check_gcloud_sdk(host)
    Fedora().check_gcloud_sdk(host)
