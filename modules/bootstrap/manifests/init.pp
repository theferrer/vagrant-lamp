class bootstrap {
  group { "puppet": 
    ensure => "present", 
  }

  if $virtual == "virtualbox" and $fqdn == '' {
    $fqdn = "localhost"
  }

  exec { "apt-get update":
    command => "apt-get update",
  }

  Package { require => Exec["apt-get update"] }
  File { require => Exec["apt-get update"] }
}