class user::default ($username, $uid) {

    $source_folder = 'puppet:///modules/user'

        group { 'puppet':
            ensure  => present,
        }

        file { "/home/${username}/":
            ensure  => directory,
            owner   => "${username}",
            group   => "${username}",
        }

        file { "/home/${username}/Apps":
            ensure  => directory,
            owner   => "${username}",
            group   => "${username}",
            mode    => 750,
            #require => File["/home/${username}/"],
        }
        
        file { "/home/${username}/Cloud":
            ensure  => directory,
            owner   => "${username}",
            group   => "${username}",
            mode    => 750,
            #require => File["/home/${username}/"],
        }

        file { "/home/${username}/bin":
            ensure  => directory,
            owner   => "${username}",
            group   => "${username}",
            mode    => 750,
            require => File["/home/${username}/"],
        }

        file { "/home/${username}/.inputrc":
            owner   => "${username}",
            group   => "${username}",
            mode    => 644,
            require => File["/home/${username}/"],
            source  => "$source_folder/inputrc",
        }

        file { "/home/${username}/.bashrc":
            owner   => "${username}",
            group   => "${username}",
            mode    => 644,
            require => File["/home/${username}/"],
            source  => "$source_folder/bashrc",
        }

        file { "/home/${username}/.vimrc":
            owner   => "${username}",
            group   => "${username}",
            mode    => 644,
            require => File["/home/${username}/"],
            source  => "$source_folder/vimrc",
        }

        file { "/home/${username}/.profile":
            owner   => "${username}",
            group   => "${username}",
            mode    => 644,
            require => File["/home/${username}/"],
            source  => "$source_folder/profile",
        }

        file { "/home/${username}/.tmux.conf":
            owner   => "${username}",
            group   => "${username}",
            mode    => 750,
            require => File["/home/${username}"],
            source  => "$source_folder/tmux.conf",
        }

        file { "/home/${username}/Cloud/.environment":
            owner   => "${username}",
            group   => "${username}",
            mode    => 644,
            require => File["/home/${username}/Cloud"],
            source  => "$source_folder/environmentrc",
        }

        file { "/home/${username}/.gitconfig":
            owner   => "${username}",
            group   => "${username}",
            mode    => 644,
            require => File["/home/${username}/"],
            source  => "$source_folder/gitconfig",
        }


}
