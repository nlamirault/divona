import abc
import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


class Distribution(abc.ABC):

    @abc.abstractmethod
    def check_windows_managers(self):
        pass

    def check_package_installed(self, host, packages):
        for pkg in packages:
            assert host.package(pkg).is_installed


class Archlinux(Distribution):

    def check_windows_managers(self, host):
        self.check_package_installed(host, [
            "i3-wm", "i3status", "i3lock", "dmenu", "rofi",
            "openbox", "openbox-themes", "obconf", "obmenu",
            "xfce4", "xfce4-notifyd",
            "conky", "thunar", "thunar-volman", "thunar-archive-plugin",
            "xautolock",
        ])


class Debian(Distribution):

    def check_windows_managers(self, host):
        self.check_package_installed(host, [
            "i3", "i3lock", "dmenu", "rofi",
            "openbox", "obconf", "obmenu",
            "xfce4", "xfce4-notifyd",
            "conky-all", "thunar", "thunar-volman", "thunar-archive-plugin",
        ])


class Centos(Distribution):

    def check_windows_managers(self, host):
        self.check_package_installed(host, [
             "i3", "i3status", "i3lock",
             "openbox",
             "xfce4-panel", "xfce4-session", "xfce4-settings",
             "conky", "Thunar", "thunar-volman", "thunar-archive-plugin"
        ])


class Fedora(Distribution):

    def check_windows_managers(self, host):
        self.check_package_installed(host, [
             "i3", "i3status", "i3lock", "dmenu", "xbacklight",
             "conky"
        ])


def _create_distribution(name):
    platform = None
    if name == "archlinux":
        platform = Archlinux()
    elif name == "centos":
        platform = Centos()
    elif name == "fedora":
        platform = Fedora()
    return platform


def test_windows_manangers(host):
    distribution = _create_distribution(host.system_info.distribution)
    if distribution:
        distribution.check_windows_managers(host)
