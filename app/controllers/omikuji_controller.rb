class OmikujiController < ApplicationController
    def show
      # 1. おみくじデータの定義
      fortunes = {
        "大吉" => { img: "daikichi.png", msg: "最高の一日になります！" },
        "中吉" => { img: "chukichi.png", msg: "良いことが重なりそうです。" },
        "小吉" => { img: "shokichi.png", msg: "小さな幸せを見つけられるかも。" },
        "吉"   => { img: "kichi.png",    msg: "穏やかで平穏な一日。" },
        "凶"   => { img: "kyo.png",      msg: "忘れ物や落とし物に注意。" }
      }
  
      # 2. 抽選
      @result_name = fortunes.keys.sample
      data = fortunes[@result_name]
      @image_file = data[:img]
      @message = data[:msg]
  
      # 3. DBへ保存
      Result.create(fortune: @result_name, message: @message)
  
      # 4. 統計データの計算
      @total_count = Result.count
      @daikichi_count = Result.where(fortune: "大吉").count
      @daikichi_percent = @total_count > 0 ? ((@daikichi_count.to_f / @total_count) * 100).round(1) : 0
  
      # 5. 最新履歴5件の取得
      @history = Result.order(created_at: :desc).limit(5)
    end
  
    def destroy_all
      Result.destroy_all
      redirect_to root_path, notice: "参拝履歴をすべてお清め（削除）しました。"
    end
  end