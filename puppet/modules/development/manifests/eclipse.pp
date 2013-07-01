import 'util.pp'

class development::eclipse ($username) {

  $eclipse_location = "/home/$username/Apps"
  $eclipse_archive  = 'eclipse-jee-juno-SR1-linux-gtk.tar.gz'


  exec { "/bin/mkdir -p ${eclipse_location} && /bin/tar xzf /tmp/${eclipse_archive} -C ${eclipse_location} && /bin/chown -R ${username}:${username} ${eclipse_location}" :
    alias   => 'install_eclipse',
    unless  => "/usr/bin/test -d ${eclipse_location}/eclipse",
    require => Download_File['download_eclipse'],
  }

  download_file { "${eclipse_archive}" :
    alias  => 'download_eclipse',
    site   => 'http://eclipse.ialto.com/technology/epp/downloads/release/juno/SR1/',
    cwd    => '/tmp',
    unless => "/usr/bin/test -d ${eclipse_location}/eclipse",
  }
}
