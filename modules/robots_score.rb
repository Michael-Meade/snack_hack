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
                if l.include?("Disallow:")
                    #  remove any empty elements
                    deny =  l.split("Disallow: ").reject { |r| r.empty? }
                    if !results.include?(deny)
                        results += deny
                    end
                end
            end 
        Reports.new(url, results.join("\n"), "robots_score.txt").save_txt
        end
    end
end

#Disallow: