class commonlisp ($username) {

  package { 'lisp_packages':
    name   => [ 'sbcl', 'sbcl-doc', 'sbcl-source', 'curl' ],
    ensure => present
  }

  file { 'bin_dir':
    path   => "/home/$commonlisp::username/Apps",
    ensure => directory,
    owner  => $username,
  }

  exec { 'download quicklisp':
    command => "/usr/bin/curl http://beta.quicklisp.org/quicklisp.lisp -o /home/$commonlisp::username/Apps/quicklisp.lisp",
    require => Package['lisp_packages'],
  }
  
  file { 'sbcl-ql-install.lisp':
    path    => "/home/$commonlisp::username/Apps/sbcl-ql-install.lisp",
    ensure  => present,
    source  => 'puppet:///modules/commonlisp/sbcl-ql-install.lisp',
    require => File['bin_dir']
  }

  file { 'sbcl-ql-setup.sh' :
    path    => "/home/$commonlisp::username/Apps/sbcl-ql-setup.sh",
    ensure  => present,
    owner   => $username,
    mode    => '750',
    source  => 'puppet:///modules/commonlisp/sbcl-ql-setup.sh',
    require => File['bin_dir']
  }
  
}
