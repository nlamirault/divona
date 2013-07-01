class common::motd {

    file { 'motd':
        ensure  => present,
        path    => '/etc/motd',
        mode    => '0644',
        source  => 'puppet:///modules/common/motd',
    }

}

