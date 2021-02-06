require './lib/reports'
require 'excon'
module SnackHack
    module HttpInfo
        # each module needs this to work. 
        def self.run(url)
            h = {}
            response = Excon.get(File.join(url, "/robots.txt"))
            content  = response.headers
            # gets the server name
            # makes sure it has a key with the name server
            if content.has_key?('server')
                server = content[:server]
                # ngix has 
                if server.match("nginx")
                    h["sever"]   = "Nginx"
                    rsp     = Excon.get(File.join( url, "server-status"))
                    # if the pages gives a status of NOT 400
                    if rsp[:status].to_i != 400
                        puts
                    end
                elsif server.match("Apache")
                    h["server"]       = "Apache"
                    rsp     = Excon.get(File.join( url, "server-status"))
                    # if the pages gives a status of NOT 400
                    if rsp[:status].to_i != 400
                        h["service-page"] = true
                    else
                        h["service-page"] = false
                    end
                end
            end
            p url
            Reports.new(url, h, "http_info.json" ).save_json
        end
    end
end