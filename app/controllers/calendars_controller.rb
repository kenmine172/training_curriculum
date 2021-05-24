class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
    # Parameters: {"authenticity_token"=>"cZj5x2r5/3rCf7aTPuwzgDeffe5h7mX2iRULzoPemU8An+9A41vlLqxkssNxBneTYJLV1LS8PoituU3v8soqZg==", "plan"=>{"date"=>"2021-05-30", "plan"=>"冨樫"}, "commit"=>"保存"}
    # .requireは２重ハッシュの外側のキーを記述する。いきなり取りにはいけないので狙いを定める。例）params[:plan]
    # .permit実際にとる。.requireで指定したキーの中にあるハッシュデータの中身を取りたい。例）params[:plan][:date] , params[:plan][:plan]
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end

      
      wday_num = Date.today.wday
    if 
      wday_num = wday_num -7
    end
      days = { month: (@todays_date + x).month, date: (@todays_date + x).day, plans: today_plans, wday: wdays[wday_num]}#wdays[3]=>'(水)' , wdays[wday_num]
      @week_days.push(days)
    end

    

    #   days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: today_plans}
    #   @week_days.push(days)
    # end
  end
end
