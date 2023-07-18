class PaymentCollectionsController < ApplicationController
  layout 'after_login_layout'
  def index
  end

  def new
    @payment_collection = PaymentCollection.new
    3.times { @payment_collection.payments.push(Payment.new) }
  end

  def create
    @payment_collection = Child.find(params[:child_id]).payment_collections.build(payment_collection_params)
    if @payment_collection.save
      redirect_to mypage_path(params[:child_id]), success: '入金しました'
    else
      flash.now[:danger] = '入金に失敗しました'
      render mypage_path(params[:child_id])
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def payment_collection_params
    params.require(:payment_collection).permit(
      :paymented_at,
      payment_attributes: [:item, :amount]
    )
  end
end
