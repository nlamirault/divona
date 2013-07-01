class common::changelog {

    file { 'chroot_changelog':
        ensure  => present,
        path    => '/etc/ChangeLog',
        mode    => '0644',
        source  => 'puppet:///modules/common/ChangeLog',
    }

}
