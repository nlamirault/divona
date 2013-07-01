class common::apt {

  exec { 'apt-upgrade':
    command => '/usr/bin/apt-get upgrade --yes --force-yes',
    require => Exec['apt-update']
  }

  exec { 'apt-update':
    command => '/usr/bin/apt-get update',
    require => File['sources_list'],
  }

  file { '/etc/apt/sources.list':
    alias  => 'sources_list',
    source => 'puppet:///modules/common/sources.list',
  }

  # Ensure apt is setup before running apt-get update
  #Apt::Key <| |> -> Exec["apt-update"]
  #Apt::Source <| |> -> Exec["apt-update"]

  # Ensure apt-get update has been run before installing any packages
  Exec['apt-update']  -> Package <| |>
  Exec['apt-upgrade'] -> Package <| |>

}
