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
            #最終フレーム以外でスペアなら、スコアにボーナスを含めて合計する
            if score.inject(:+) == 10 && index < 10
                @total_score += 10 + @scores[index].first
            else
                @total_score += score.inject(:+)
            end
        end
    end
end