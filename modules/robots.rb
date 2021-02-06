require './lib/reports'
require 'excon'
module SnackHack
    module Robots
        # each module needs this to work. 
        def self.run(url)
            response = Excon.get(File.join("https://", url, "/robots.txt"))
            content  = response.body
            # saves the results of robots.txt to the file
            # it will create the directory for the site.
            Reports.new(url, content, "robots.txt" ).save_txt
        end
    end
end