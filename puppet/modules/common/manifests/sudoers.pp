class common::sudoers {

    file { 'chroot_sudoers':
        ensure => present,
        path   => '/etc/sudoers',
        source => 'puppet:///modules/common/sudoers',
        owner  => 'root',
        group  => 'root',
        mode   => 440,
    }


}
