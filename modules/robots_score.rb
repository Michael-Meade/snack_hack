require './lib/reports'
require 'excon'
module SnackHack
    module RobotsScore
        def self.run(url)
            results  = []
            response = Excon.get(File.join(url, "robots.txt"))
            text     = response.body
            contents = text.split("\n").each { |c|  }.to_a
            contents.each do |l|
                # makes sure that the line has the 
                # string "Disallow:" in it
                if l.include?("Disallow:")
                    #  remove any empty elements that are empty
                    deny =  l.split("Disallow: ").reject { |r| r.empty? }
                    # makes sure that its not already in the array.
                    if !results.include?(deny)
                        # if is not found in the array
                        # it will add it to the results array
                        results += deny
                    end
                end
            end
            # saves the results into the file named robots_score.txt
            Reports.new(url, results.join("\n"), "robots_score.txt").save_txt
            score = 0
            new_url = url.to_s.gsub("https://", "").gsub("http://", "")
            File.readlines(File.join("reports", new_url, "robots_score.txt")).each do |l|
                l = l.strip
                response = Excon.get(File.join(url, l))
                if response.status.to_i == 200
                    score+=1
                end
            end
            Scoring.new(score, File.join("reports", new_url, "robots_score.txt")).calc
        end
    end
end

#Disallow: