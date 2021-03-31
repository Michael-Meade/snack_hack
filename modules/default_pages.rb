require 'excon'
module SnackHack
    module DefaultPages
        def self.run(url)
            File.readlines(File.join("lists", "default_status.txt")).each do |path|
                response = Excon.get(File.join("https://", url, path.strip))
                content  = response.body
                # first we should check to make sure that the server gave us a 200 status code back
                if response.status.to_i == 200
                    puts "Detected default status page at :#{File.join(url, path.strip)}"
                    Reports.new(url, path, "default_status_pages.txt" ).save_txt
                end
            end
        end
    end
end