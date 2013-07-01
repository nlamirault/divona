define download_file($site="", $cwd="", $creates="", $unless="") {

    exec { $name:
        command => "/usr/bin/wget ${site}/${name}",
        cwd     => "${cwd}",
        creates => "${cwd}/${name}",
        unless  => "${unless}",
    }

}   

