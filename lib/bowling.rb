class Bowling
    #インスタンスを生成するときに処理が実行される
    def initialize
        @total_score = 0
        @scores = []
        @temp = []
        @frame_score =[]
    end
    
    #スコア合計を返す
    def total_score
        @total_score
    end    
    
    def add_score(pins)
        #一時保存用スコアに、倒したピンの数を追加する
        @temp << pins
        #2投分のデータが入っている、またはストライクで、1フレーム分のスコアとして全体に追加する
        if @temp.size == 2 || strike?(@temp)
           @scores << @temp
           @temp =[]
        end
    end
    
    def calc_score
        @scores.each.with_index(1) do |score, index|
            #ストライクかつ 最終フレーム以外の場合、スコアにボーナスを含めて合計する
            if score.first == 10 && index < 10
            #次のフレームもストライクで、なおかつ最終フレーム以外なら、
            #もう一つ次のフレームの一投目をボーナス対象にする。
                if strike?(@scores[index]) && not_last_frame?(index + 1)
                    @total_score += 20 + @scores[index + 1].first
                else
                    @total_score += 10 + @scores[index].inject(:+)
                end
            #スペアかつ 最終フレーム以外の場合、スコアにボーナスを含めて合計する
            elsif score.inject(:+) == 10 && index < 10
                @total_score += 10 + @scores[index].first #calc_spare_bonus(index)
            else
                @total_score += score.inject(:+)
            end
            @frame_score << @total_score
        end
    end
    #スペア処理リファクタリング時に正常に動かなかった
    private
    #def spare_(score)
    #    score.inject(:+) == 10
    #end
    def strike?(score)
        score.first == 10
    end
    def not_last_frame?(index)
        index < 10
    end
    #def calc_spare_bonus(index)
    #    10 + @score[index].first
    #end
end