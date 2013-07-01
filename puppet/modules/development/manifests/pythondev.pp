class development::pythondev ($username) {

    exec { "python_virtualenv":
        command => "/usr/bin/sudo /usr/bin/pip install virtualenv",
        require => Package['python-dev']
    }

    exec { "python_virtualenvwrapper":
        command => "/usr/bin/sudo /usr/bin/pip install virtualenvwrapper",
        require => Exec['python_virtualenv']
    }

    exec { "python_createvirtualenv_directory":
        command => "/bin/mkdir /home/$common::pythondev::username/.virtualenvs",
        require => Exec['python_virtualenvwrapper'],
        unless  => "/usr/bin/test -d /home/$common::pythondev::username/.virtualenvs"
    }

    exec { "python_jedi":
        command => "/usr/bin/sudo /usr/bin/pip install jedi",
        require => Package['python-dev']
    }

    exec { "python_epc":
        command => "/usr/bin/sudo /usr/bin/pip install epc",
        require => Package['python-dev']
    }

    exec { "python_elpy":
        command => "/usr/bin/sudo /usr/bin/pip install elpy",
        require => Package['python-dev']
    }
}
