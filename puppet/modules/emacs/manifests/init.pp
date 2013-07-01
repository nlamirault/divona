class emacs ($username) {
   
    exec { "ppa_emacs":
        command => "/usr/bin/add-apt-repository --yes ppa:cassou/emacs",
        require => Package['debian_tools']
    }
    
    exec { "ppa_emacs_ready":
        command => "/usr/bin/apt-get update",
        require => Exec['ppa_emacs']
    }
    
    package {'emacs':
        ensure  => installed,
        name    => 'emacs24',
        require => Exec['ppa_emacs_ready']
    }

    file { 'emacs_directory':
        ensure  => directory,
        path    => "/home/$emacs::username/.emacs.d",
        owner   => "$username",
        group   => "$username",
        require => Package['emacs']
    }
    
    file { 'emacs_main_config':
        ensure  => present,
        path    => "/home/$emacs::username/.emacs",
        owner   => "$username",
        group   => "$username",
        source  => 'puppet:///modules/emacs/emacs',
        require => File['emacs_directory']
    }

    file { 'emacs_mbs_config':
        ensure  => present,
        path    => "/home/$emacs::username/.emacs.d/mbs.el",
        owner   => "$username",
        group   => "$username",
        source  => 'puppet:///modules/emacs/mbs.el',
        require => File['emacs_directory']
    }

    
    file { 'emacs_openstack_config':
        ensure  => present,
        path    => "/home/$emacs::username/.emacs.d/openstack.el",
        owner   => "$username",
        group   => "$username",
        source  => 'puppet:///modules/emacs/openstack.el',
        require => File['emacs_directory']
    }
    
    file { 'emacs_elget':
        ensure  => directory,
        recurse => true,
        purge   => true,
        force   => true,
        path    => "/home/$emacs::username/.emacs.d/el-get",
        owner   => "$username",
        group   => "$username",
        source  => 'puppet:///modules/emacs/el-get',
        require => File['emacs_directory']
    }
    
 
    file { 'emacs_dev_php':
        ensure  => present,
        path    => "/home/$emacs::username/.emacs.d/php.el",
        owner   => "$username",
        group   => "$username",
        source  => 'puppet:///modules/emacs/php.el',
        require => File['emacs_prelude']
    }


    file { 'emacs_prelude_python':
        ensure  => present,
        path    => "/home/$emacs::username/.emacs.d/prelude/personal/python.el",
        owner   => "$username",
        group   => "$username",
        source  => 'puppet:///modules/emacs/python.el',
        require => File['emacs_prelude']
    }

    
    
}
