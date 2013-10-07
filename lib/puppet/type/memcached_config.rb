Puppet::Type.newtype(:memcached_config) do
  newparam(:name, :namevar => true) do
    desc "The name of the config section"
    newvalues(:logfile, :max_memory, :item_size, :lock_memory, :listen_ip, :tcp_port, :udp_port, :user, :max_connections, :verbosity, :unix_socket, :pid_path)
  end

  newproperty(:value) do
    desc 'The value of the setting to be defined.'
    flag_map = { logfile: "logfile", 
                max_memory: "-m", 
                item_size: "-I", 
                lock_memory: "-k", 
                listen_ip: "-l", 
                tcp_port: "-p", 
                udp_port: "-U", 
                user: "-u", 
                max_connections: "-c", 
                verbosity: "", 
                unix_socket: "-s", 
                pid_path: "-P"  }

    munge do |value|
      value = value.to_s.strip
      # Boolean stuff that just enables a flag with no arguments
      if value =~ /^(true|false)$/i 
        if value == 'true'
          value = flag_map[@resource[:name]] 
        else
          value = ""
      # Verbose sucks
      elsif @resource[:name] == :verbosity
        value = "-" + value
      # All the rest
      else
        value = flag_map[@resource[:name]] + " " + value + "\n"
      end 
      value
    end
  end
end
