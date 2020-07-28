class Bowling
    #インスタンスを生成するときに処理が実行される
    def initialize
        @total_score = 0
        @scores = []
        @temp = []
    end
    
    #スコア合計を返す
    def total_score
        @total_score
    end    
    
    def add_score(pins)
        #一時保存用スコアに、倒したピンの数を追加する
        @temp << pins
        #2投分のデータが入っていれば、1フレーム分のスコアとして全体に追加する
        if @temp.size == 2
           @scores << @temp
           @temp =[]
        end
    end
    
    def calc_score
        @scores.each.with_index(1) do |score, index|
            #スペアかつ 最終フレーム以外の場合、スコアにボーナスを含めて合計する
            if spare?(score)&& not_last_frame?(index)
                @total_score += 10 + calc_spare_bonus(index)
            else
                @total_score += score.inject(:+)
            end
        end
    end
    
    private
    def spare?(score)
        score.inject(:+) == 10
    end
    
    def not_last_frame?(index)
        index < 10
    end
    
    def calc_spare_bonus(index)
        10 + @score[index].first
    end
end