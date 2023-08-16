class MypageController < ApplicationController
  layout 'after_login_layout'
  before_action :auto_payment
  def show
    @savings_datas = @child.payments.group(:item).sum(:amount)
    @each_stage_cost = @child.result.each_stage_cost if @child.result.present?
  end

  private

  def auto_payment
    # @childのplansでis_auto属性がtrueかつpayment_dayの値が本日よりも前のものを取得
    auto_plans = @child.plans.where(is_auto: true).where("payment_day < ?", Date.today.day)

    # 今日の日付と同じ月の条件を設定
    current_month_conditions = {
      created_at: Date.today.beginning_of_month..Date.today.end_of_month
    }

    # @childのpaymentsで、条件に合致するPaymentインスタンスを取得
    existing_payments = @child.payments.where(current_month_conditions)

    # auto_plansの中から、まだpaymentが存在しないものをフィルタリング
    auto_plans_to_process = auto_plans.reject do |plan|
      existing_payments.any? { |payment| payment.item == plan.item }
    end

    unless auto_plans_to_process.empty?
      # payment_collectionsにpayment_dayごとのプランを格納するハッシュを初期化
      payment_collections = Hash.new { |hash, key| hash[key] = [] }
    
      # auto_plans_to_processをpayment_dayごとに分類
      auto_plans_to_process.each do |plan|
        payment_collections[plan.payment_day] << plan
      end
    
      # 各payment_dayごとにpayment_collectionを生成して保存
      payment_collections.each do |payment_day, plans|
        payment_collection = @child.payment_collections.create(paymented_at: Date.parse("#{Date.today.year}/#{Date.today.month}/#{payment_day}"), is_auto: true)
        
        plans.each do |plan|
          payment_params = {
            item: plan.item,
            amount: plan.amount,
          }
          payment_collection.payments.create(payment_params)
        end
      end
    end
    
  end
end
