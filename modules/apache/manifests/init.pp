class apache {
  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    enable => true,
    require => Package['apache2'],
    subscribe => [
      File["/etc/apache2/mods-enabled/rewrite.load"],
      File["/etc/apache2/sites-available/default"],
      File["/etc/php5/apache2/php.ini"]
    ],
  }

  file { "/etc/apache2/mods-enabled/rewrite.load":
    ensure => link,
    target => "/etc/apache2/mods-available/rewrite.load",
    require => Package['apache2'],
  }

  file { "/etc/apache2/sites-available/default":
    ensure => present,
    source => "/vagrant/config/virtualhost",
    require => Package['apache2'],
  }

  exec { "UsergroupChange" :
    command => "sed -i 's/USER=www-data/USER=vagrant/ ; s/GROUP=www-data/GROUP=vagrant/' /etc/apache2/envvars",
    onlyif  => "grep -c 'export APACHE_RUN_USER=www-data' /etc/apache2/envvars",
    require => Package["apache2"],
    notify  => Service['apache2'],
  }

  exec { 'echo "ServerName localhost" | sudo tee /etc/apache2/conf.d/fqdn':
    require => Package['apache2'],
  }
}