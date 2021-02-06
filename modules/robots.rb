require 'excon'
module SnackHack
    module Robots
        # each module needs this to work. 
        def self.run(url)
            response = Excon.get(url)
            response.body
        end
    end
end