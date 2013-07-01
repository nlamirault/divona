import 'util.pp'

class development::ant ($username) {

  $ant_location = "/home/${username}/Apps"
  $ant_archive  = 'apache-ant-1.9.0-bin.tar.gz'

  exec { "/bin/mkdir -p ${ant_location} && /bin/tar xzf /tmp/${ant_archive} -C ${ant_location} && /bin/chown -R ${username}:${username} ${ant_location}" :
    alias   => 'install_ant',
    unless  => "/usr/bin/test -d ${ant_location}/apache-ant-1.9.0",
    require => Download_File['download_ant'],
  }

  download_file { "${ant_archive}" :
    alias  => 'download_ant',
    site   => 'http://mirrors.ircam.fr/pub/apache/ant/binaries/',
    cwd    => '/tmp',
    unless => "/usr/bin/test -d ${ant_location}/apache-ant-1.9.0",
  }

}
