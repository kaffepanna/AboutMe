class ActiveRecord::ConnectionAdapters::AbstractAdapter
  protected

  def log_with_trunkate(sql, name="SQL", binds=[], &block)
    b = binds.map {|k,v| 
      v = v.truncate(20) if v.is_a? String and v.size > 20
      [k,v]
    }
    s = sql.gsub(/x\'[A-Za-z0-9]+\'/) { |match| match.size > 20 ? "'...'" : match }
    log_without_trunkate(s, name, b, &block)
  end

  alias_method_chain :log, :trunkate
end

