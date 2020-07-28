require "bowling"

describe "ボウリングのスコア計算" do
    #インスタンス生成を共通化
    before do
        @game = Bowling.new
    end
    
    describe "全体の合計" do
        context "すべての投球がガーターだった場合" do
            it "0になること" do
               #(インスタンス生成)
               #20回0点
                add_many_scores(20,0)
                #合計を計算
                @game.calc_score
                expect(@game.total_score).to eq 0
            end
        end
        context "すべての投球で１ピンずつ倒した場合" do
            it "20になること" do
               #(インスタンス生成)
               #20回1点
                add_many_scores(20,1)
                #合計を計算
                @game.calc_score
                expect(@game.total_score).to eq 20
            end
        end
        context "スペアをとった場合" do
            it "スペアボーナスが加算されること" do
                #第一フレームで3+7のスペア、第二フレーム一投目で4,以降は0
                @game.add_score(3)
                @game.add_score(7)
                @game.add_score(4)
                add_many_scores(17,0)
                #合計を計算（期待する合計は 3+7+4+4(スペアボーナス)=18
                @game.calc_score
                expect(@game.total_score).to eq 18                
            end
        end
        context "フレーム違いでスペアになるようなスコアの場合" do
            it "スペアボーナスが加算[されない]こと" do
                #
                @game.add_score(3)
                @game.add_score(5)
                @game.add_score(5)
                @game.add_score(4)
                add_many_scores(16,0)
                #合計を計算（期待する合計は 3+5+5+4(スペアボーナス)=17
                @game.calc_score
                expect(@game.total_score).to eq 17                
            end
        end
        context "最終フレームでスペアをとった場合" do
            it "スペアボーナスが加算されること" do
                #第一フレームで3+7のスペア、第二フレーム一投目で4,以降は15投0点で、最終フレームで3+7のスペア
                @game.add_score(3)
                @game.add_score(7)
                @game.add_score(4)
                add_many_scores(15,0)
                @game.add_score(3)
                @game.add_score(7)
                #合計を計算（期待する合計は 3+7+4+4(スペアボーナス)+3+7=28
                @game.calc_score
                expect(@game.total_score).to eq 28                
            end
        end
        
        context "ストライクをとった場合" do
            it "ストライクボーナスが加算されること" do
                #第一フレームでストライク、第二フレームで5+4,以降は0
                @game.add_score(10)
                @game.add_score(5)
                @game.add_score(4)
                add_many_scores(16,0)
                #合計を計算（期待する合計は 10+5+4+(5+4)=28
                @game.calc_score
                expect(@game.total_score).to eq 28                
            end
        end
        context "ダブルをとった場合" do
            it "それぞれのストライクボーナスが加算されること" do
                #第一、第二フレームでストライク、第三フレームで5+4,以降は0
                @game.add_score(10)
                @game.add_score(10)
                @game.add_score(5)
                @game.add_score(4)
                add_many_scores(14,0)
                #合計を計算（期待する合計は 10+10+5+4+(10+5)+(5+4)=53
                @game.calc_score
                expect(@game.total_score).to eq 53                
            end
        end
        context "ターキー（３ストライク）をとった場合" do
            it "それぞれのストライクボーナスが加算されること" do
                #第一、第二フレームでストライク、第三フレームで5+4,以降は0
                @game.add_score(10)
                @game.add_score(10)
                @game.add_score(10)
                @game.add_score(5)
                @game.add_score(4)
                add_many_scores(12,0)
                #合計を計算（期待する合計は 10+10+10+5+4+(10+10)+(10+5)+(5+4)=83
                @game.calc_score
                expect(@game.total_score).to eq 83                
            end
        end
        context "最終フレームでストライクをとった場合" do
            it "ストライクボーナスが加算[されない]こと" do
                #第一フレームでストライク、第二フレームで5+4,3~9フレームは0,10フレームでストライク
                @game.add_score(10)
                @game.add_score(5)
                @game.add_score(4)
                add_many_scores(14,0)
                @game.add_score(10)             
                #合計を計算（期待する合計は 10+5+4+(5+4)+10=38
                @game.calc_score
                expect(@game.total_score).to eq 38  
            end
        end
    end
end
private
def add_many_scores(count, pins)
    count.times do
        @game.add_score(pins)
    end
end