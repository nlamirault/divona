class user::vim ($username) {

    exec { 'create_vim_dir':
        command => "/bin/mkdir /home/$username/.vim",
        cwd     => "/home/$username",
        user    => "$username",
        group   => "$username",
        require => Class['user::default'],
        unless  => "/usr/bin/test -d /home/$username/.vim",
    }
    
    exec { 'create_vim_bundle':
        command => "/bin/mkdir /home/$username/.vim/bundle",
        cwd     => "/home/$username",
        user    => "$username",
        group   => "$username",
        require => Exec['create_vim_dir'],
        unless  => "/usr/bin/test -d /home/$username/.vim/bundle",
    }
    
    exec { 'install_vundle':
        command => "/usr/bin/git clone https://github.com/gmarik/vundle.git /home/$username/.vim/bundle/vundle",
        cwd     => "/home/$username",
        user    => "$username",
        group   => "$username",
        require => Exec['create_vim_bundle'],
        unless  => "/usr/bin/test -d /home/$username/.vim/bundle/vundle",
    }


}
