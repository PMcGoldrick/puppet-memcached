Puppet::Type.type(:memcached_config).provide( :config_setting) do
  def create
    lines = File.new(@resource[:fp], 'r').readlines
    lines.each_index do |i|
      if lines[i][0..1] == @resource[:value][0..1]
        lines[i] = @resource[:value]
        return true
      end
    end
    lines << @resource[:value]
  end

  def destroy
    lines = File.new(@resource[:fp], 'r').readlines
    lines.each_index do |i|
      if lines[i][0..1] == @resource[:value][0..1]
        lines[i] = ""
      end

      fh = File.new(@resource[:fp], 'w')
      for line in lines
        fh.write(line)
      end
      fh.close
    end
  end

  def exists?
    lines = File.new('/etc/sysctl.conf', 'r').readlines
    lines.each do |line|
      if line == @resource[:value]
        return true
      end
    end
    return false
  end
  
  def value=(val)
    if not @resource.exists?
      @resource.create
    end
  end
end
