class php {
  $packages = ["php5", "libapache2-mod-php5", "php5-cli", "php5-mysql","php5-xdebug", "php-apc", "php5-gd", "php5-intl", "php5-imap", "php5-curl", "php5-sqlite", "php5-tidy", "php5-mcrypt"]
  package { $packages:
    ensure => present,
  }

  file { "/etc/php5/apache2/php.ini":
  	source => "puppet:///modules/php/php.ini",
  	require => Package["php5","libapache2-mod-php5"],
  	ensure => present,
  }

  file { "/etc/php5/cli/php.ini":
  	source => "puppet:///modules/php/php.ini",
  	require => Package["php5","php5-cli"],
  	ensure => present,
  }
}