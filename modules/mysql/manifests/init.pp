class mysql {
  $mysqlPassword = "root"
 
  package { "mysql-server":
    ensure => present,
  }

  service { "mysql":
    enable => true,
    ensure => running,
    require => Package["mysql-server"],
  }

  exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p$mysqlPassword status",
    command => "mysqladmin -uroot password $mysqlPassword",
    require => Service["mysql"],
  }

    file {
      'my.cnf':
          ensure => file,
          source => "puppet:///modules/mysql/my.cnf",
          path => '/etc/mysql/my.cnf',
          mode => 644,
          owner => root,
          group => root,
          notify => Service['mysql'],
          require => [Package["mysql-server"]]
    }

}