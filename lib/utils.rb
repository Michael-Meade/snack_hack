class Scoring
    def initialize(score, list_file )
        @score      = score.to_i
        @list_file  = list_file
    end
    def calc
        total       = File.foreach(@list_file).inject(0) {|c, line| c+1}
        final_score = total.to_i / @score.to_i
        puts "Score is: #{final_score.to_s}"
    end
end
