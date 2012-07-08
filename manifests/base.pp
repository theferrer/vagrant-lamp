Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

stage { 'first': before => Stage['main'] }
stage { 'last': require => Stage['main'] }

class { bootstrap: stage => first }

include bootstrap
include other
include apache
include php
include mysql
include phpmyadmin