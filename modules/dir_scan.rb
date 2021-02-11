require 'thread'
require 'httparty'
module SnackHack
  module DirBrute
    def self.run(ip, list = "lists/dicc.txt")
      threads = []
      begin
        
        File.readlines(list).each do |line|
          line = line.strip
          threads << Thread.new {
              r = HTTParty.get(File.join(ip, line))
              puts r.code
              if (r.code.to_i == 200 || r.code.to_i == 206)
                Reports.new(ip, File.join(@ip, line) + "\n", "dirscan.txt", "a" ).save_txt
              end
          }
          threads.each {|t| t.join}
        end
      rescue => e
        p e.backtrace
      end
    end
  end
end