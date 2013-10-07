class memcached(
  $package_ensure  = 'present',
  $logfile         = '/var/log/memcached.log',
  $max_memory      = false,
  $item_size       = false,
  $lock_memory     = false,
  $listen_ip       = '0.0.0.0',
  $tcp_port        = 11211,
  $udp_port        = 11211,
  $user            = $::memcached::params::user,
  $max_connections = '8192',
  $verbosity       = undef,
  $unix_socket     = undef,
  $install_dev     = false,
  $pid_path        = '/var/run/memcached.pid',
) inherits memcached::params {
  #Memcached_config<| |> -> File[$memcached::params::config_file]

  package { $memcached::params::package_name:
    ensure => $package_ensure,
  }

  if $install_dev {
    package { $memcached::params::dev_package_name:
      ensure  => $package_ensure,
      require => Package[$memcached::params::package_name]
    }
  }

  file { $memcached::params::config_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$memcached::params::package_name],
  }

  service { $memcached::params::service_name:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
    subscribe  => File[$memcached::params::config_file],
  }

  if $logfile{
    memcached_config{ "logfile": value => $logfile;}
  }
  if $max_memory{
    memcached_config{ "max_memory": value => $max_memory}
  }
  if $item_size{
    memcached_config{ "item_size": value => $item_size}
  }
  if $lock_memory{
    memcached_config{ "lock_memory": value => $lock_memory}
  }
  if $listen_ip{
    memcached_config{ "listen_ip": value => $listen_ip}
  }
  if $tcp_port{
    memcached_config{ "tcp_port": value => $tcp_port}
  }
  if $udp_port{
    memcached_config{ "udp_port": value => $udp_port}
  }
  if $max_connections{
    memcached_config{ "max_connections": value => $max_connections}
  }
  if $verbosity{
    memcached_config{ "verbosity": value => $verbosity}
  }
  if $unix_socket{
    memcached_config{ "unix_socket": value => $unix_socket}
  }
  if $install_dev{
    memcached_config{ "install_dev": value => $install_dev}
  }
  if $pid_path{
    memcached_config{ "pid_path": value => $pid_path}
  }
}
