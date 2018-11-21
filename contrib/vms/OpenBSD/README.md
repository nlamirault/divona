# OpenBSD

* Install python first :

        $ vagrant up --no-provision
        $ vagrant ssh
        *> sudo pkg_add http://ftp.openbsd.org/pub/OpenBSD/5.9/packages/amd64/python-2.7.11.tgz

* Provisioning VM:

        $ vagrant provision
