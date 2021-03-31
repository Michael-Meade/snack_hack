require 'excon'
module SnackHack
    module DefaultPages
        def self.scanning_file
            File.join("lists", "default_status.txt")
        end
        def self.calc_score(score)
            # The total amount of lines
            total = File.foreach(self.scanning_file).inject(0) {|c, line| c+1}
            final_score = total.to_i / score.to_i
            puts "Score is: #{final_score.to_s}"
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
        calc_score(score)
        end
    end
end