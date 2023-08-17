class PaymentCollectionDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def format_paymented_at
    "#{paymented_at.year}年#{paymented_at.month}月#{paymented_at.day}日"
  end

  def total_amount
    "¥#{payments.pluck(:amount).sum.to_s(:delimited)}"
  end

  def is_auto?
    is_auto ? '(自動入金)' : ''
  end
end
