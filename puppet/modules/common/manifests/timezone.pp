class common::timezone {
  package { ['tzdata', 'debconf']:
    ensure => installed
  }

  exec { 'reconf-tzdata':
    command     => '/usr/sbin/dpkg-reconfigure -f noninteractive tzdata',
    refreshonly => true;
  }

  file { 'timezone':
    ensure   => file,
    path     => '/etc/timezone',
    content  => "Europe/Paris\n",
    require  => Package['tzdata'],
    notify   => Exec['reconf-tzdata'];
  }
}
