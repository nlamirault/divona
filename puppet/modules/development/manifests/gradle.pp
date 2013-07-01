import 'util.pp'

class development::gradle ($username) {

  $gradle_location = "/home/$username/Apps"
  $gradle_archive  = 'gradle-1.4-all.zip'

  exec { "/bin/mkdir -p ${gradle_location} && unzip -oq /tmp/${gradle_archive} -d ${gradle_location} && /bin/chown -R ${username}:${username} ${gradle_location}" :
    alias   => 'install_gradle',
    unless  => "/usr/bin/test -d ${gradle_location}/gradle-1.4",
    require => Download_File['download_gradle'],
  }

  download_file { "${gradle_archive} " :
    alias  => 'download_gradle',
    site   => 'http://services.gradle.org/distributions',
    cwd    => '/tmp',
    unless => "/usr/bin/test -d ${gradle_location}/gradle-1.4",
  }

}
