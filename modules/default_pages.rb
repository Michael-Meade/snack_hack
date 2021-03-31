require 'excon'
require './lib/utils'
module SnackHack
    module DefaultPages
        def self.scanning_file
            File.join("lists", "default_status.txt")
        end
        def self.run(url)
            score = 0
            File.readlines(self.scanning_file).each do |path|
                response = Excon.get(File.join("https://", url, path.strip))
                content  = response.body
                # first we should check to make sure that the server gave us a 200 status code back
                if response.status.to_i == 200
                    score += 1
                    puts "Detected default status page at :#{File.join(url, path.strip)}"
                    Reports.new(url, path, "default_status_pages.txt" ).save_txt
                end
            end
        Scoring.new(score, File.join("lists", "default_status.txt")).calc
        end
    end
end