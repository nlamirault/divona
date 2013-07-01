class development::git ($username) {

    $repo = "git@github.com"
    $git_dir = "/home/$development::git::username/Cloud"
    
    file { 'git_dir' :
        ensure  => directory,
        path    =>  "$development::git::git_dir",
        owner    => "$username",
        group   => "$username",
    }

	define clone_git_repo {
	    exec { "clone_$name":
	        command => "/usr/bin/git clone $development::git::repo:$name.git",
            cwd     => "/home/$development::git::git_dir",
            user    => "$development::git::username",
            group   => "$development::git::username",
            require => File['git_dir'],
            unless => "/usr/bin/test -d $development::git::git_dir/$name",
	    }
	}
	
	clone_git_repo { [ 'nlamirault/gaia'
	                    ] : }
	                    
}
