class PaymentForm
    include ActiveModel::Model
    include ActiveModel::Callbacks
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks
  
    FORM_COUNT = 3
    attr_accessor :payments
  
    # 初期化
    # fields_forを使用するため、Paymentインスタンスを規定の個数生成する
    def initialize(attributes = {})
      super attributes
      self.payments = FORM_COUNT.times.map { Payment.new() } unless self.payments.present?
    end
  
    # 取得したパラメータを各Paymentインスタンスに格納
    def payments_attributes=(attributes)
      self.payments = attributes.map { |_, v| Payment.new(v) }
    end
  
    # paymentインスタンスの一括保存
    def save
      Payment.transaction do
        index = 0
        self.payments.map do |payment|
          payment.save!
        end
      end
        return true
      rescue => e
        return false
    end
  end