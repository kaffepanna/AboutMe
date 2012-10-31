class ActiveRecord::ConnectionAdapters::AbstractAdapter
  protected

  def log_with_trunkate(sql, name="SQL", binds=[], &block)
    b = binds.map {|k,v|
      v = v.truncate(20) if v.is_a? String and v.size > 20
      [k,v]
    }
    log_without_trunkate(sql, name, b, &block)
  end

  alias_method_chain :log, :trunkate
end

