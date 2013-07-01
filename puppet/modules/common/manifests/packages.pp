class common::packages {

  package { 'common':
    ensure  => installed ,
    name    => ['man-db', 'apt-file', 'wget', 'ngrep', 'tree', 'curl', 'bash-completion', 'language-pack-fr',
                'git', 'gitk', 'unzip', 'logrotate',
                'rsyslog', 'sysstat', 'tmux', 'w3m',
                'libgtk2.0-0', 'libswt-gtk-3-jni', 'libswt-gtk-3-java',
                'mlocate', 'genisoimage'],
  }

  package { 'tools':
    ensure => installed,
    name   => ['dnsutils' , 'puppet', 'puppet-lint', 'vim', 'vim-puppet'],
  }

  package { 'python-dev':
    ensure => installed,
    name   => ['python-pip', 'pylint', 'python-mysqldb','python-simplejson','python-pycurl'],
  }
        
  package { 'debian_tools':
    ensure => installed,
    name   => ['python-software-properties'],
  }

  package { 'windowmanager':
    ensure => installed,
    name   => ['openbox', 'openbox-themes', 'obconf', 'obmenu', 'conky-all',
               'thunar', 'thunar-volman', 'thunar-archive-plugin',
               'tint2'],
  }
  
  package { 'web':
    ensure => installed,
    name   => ['chromium-browser','midori'],
  }

  package { 'mail':
    ensure => installed,
    name   => ['thunderbird','thunderbird-locale-fr'],
  }

  package { 'graphics':
    ensure => installed,
    name   => ['gimp', 'inkscape','evince','vlc']
  }

  package { 'communication':
    ensure => installed,
    name   => ['irssi','vinagre','rdesktop']
  }

}

