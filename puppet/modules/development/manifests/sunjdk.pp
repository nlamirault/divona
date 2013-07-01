import "util.pp"

class development::sunjdk ( $username ) {

  $jdk_location = "/home/${username}/Apps"
  $jdk_archive  = 'jdk1.6.0_30.tar.gz'

  exec { "/bin/mkdir -p ${jdk_location} && /bin/tar xzf /tmp/${jdk_archive} -C ${jdk_location} && /bin/chown -R ${username}:${username} ${jdk_location}" :
    alias   => 'install_jdk',
    unless  => "/usr/bin/test -d ${jdk_location}/jdk1.6.0_30",
    require => Download_File['download_jdk'],
  }

  download_file { "${jdk_archive}" :
    alias  => 'download_jdk',
    site   => 'http://maven01b.int33.cvf/maven/com/sun/jdk/1.6',
    cwd    => '/tmp',
    unless => "/usr/bin/test -d ${jdk_location}/jdk1.6.0_30",
  }
}
