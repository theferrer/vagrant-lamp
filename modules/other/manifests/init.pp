class other {
  $packages = ["htop", "curl", "tmux","vim","git-core","acl", "subversion"]
  package { $packages:
    ensure => present,
  }
}