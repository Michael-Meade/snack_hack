require './lib/reports'
require 'excon'
module SnackHack
    module ServerInfo
        def self.run(url)
            response = Excon.get(url)
            b        = response.body
            content  = response.headers
            # gets the server name
            # makes sure it has a key with the name server
            if content.has_key?('server')
                server = content[:server]
                puts server
            end
        end
    end
end