@env = ENV["RAILS_ENV"] || "development"

def bootstrap(cmd, log)
  system_perform(%(ruby script/runner -e #{@env} '#{cmd}' >> 'log/#{log}.log' 2>&1))
rescue => e
  puts "error:" + e.message + "\r\n" + e.backtrace.join("  \r\n")
end

def system_perform(string)
  system(string)
  if ($?.exitstatus != 0) 
    raise "exitstatus:#{$?.exitstatus}\r\ncommand:#{string}" 
  end
  puts "success:" + string + "\r\n"
end