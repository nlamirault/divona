import 'user'
import 'common'
import 'development'

include common


$myuser = "vagrant"

stage { pre: before => Stage[main] }

class { common::apt:
     stage => pre
}

class { common::packages:
     stage => pre
}

class { 'user::default':
    stage    => pre,
    username => $myuser,
    uid      => 2000,
}

class { 'user::vim':
    username => $myuser,
}

host { 'localhost':
        ip           => '127.0.0.1',
        host_aliases => [ 'test'],
}

class { 'emacs':
    username    => $myuser
}


class { 'development::pythondev': 
      username => $myuser
}

