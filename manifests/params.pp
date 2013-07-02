class memcached::params {
  case $::osfamily {
    'Debian': {
      $package_name     = 'memcached'
      $service_name     = 'memcached'
      $dev_package_name = 'libmemcached-dev'
      $config_file      = '/etc/memcached.conf'
      $config_tmpl      = "$module_name/memcached.conf.erb"
      $user             = 'nobody'
      $create_pid       = false
    }
    'RedHat': {
      $package_name     = 'memcached'
      $service_name     = 'memcached'
      $dev_package_name = 'libmemcached-devel'
      $config_file      = '/etc/sysconfig/memcached'
      $config_tmpl      = "$module_name/memcached_sysconfig.erb"
      $user             = 'memcached'
      $create_pid       = true
    }
    default: {
      fail("Unsupported platform: ${::osfamily}")
    }
  }
}
