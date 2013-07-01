import 'util.pp'

class development::maven ($username) {

  $maven_location = "/home/$username/Apps"
  $maven_archive  = 'apache-maven-3.0.4-bin.tar.gz'

  exec { "/bin/mkdir -p ${maven_location} && /bin/tar xzf /tmp/${maven_archive} -C ${maven_location} && /bin/chown -R ${username}:${username} ${maven_location}" :
    alias   => 'install_maven',
    unless  => "/usr/bin/test -d ${maven_location}/apache-maven-3.0.4",
    require => Download_File['download_maven'],
  }

  download_file { "${maven_archive} " :
    alias  => 'download_maven',
    site   => 'http://archive.apache.org/dist/maven/binaries',
    cwd    => '/tmp',
    unless => "/usr/bin/test -d ${maven_location}/apache-maven-3.0.4",
  }

}
