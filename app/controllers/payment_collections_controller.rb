class PaymentCollectionsController < ApplicationController
  layout 'after_login_layout'
  def index
  end

  def new
    @payment_collection = PaymentCollection.new
    3.times.each { @payment_collection.payments.push(Payment.new) }
  end

  def create
    @payment_collection = PaymentCollection.new(payment_collection_params)
    binding.pry
    if @payment_collection.save
      redirect_to mypage_path(params[:child_id]), success: '入金しました'
    else
      flash.now[:danger] = '入金に失敗しました'
      render :new
    end
  end

  def show
  end

  def edit
    @payment_collection = PaymentCollection.find(params[:id])
  end

  def update
    @payment_collection.update(update_payment_collection_params)
  end

  def destroy
  end

  private

  def payment_collection_params
    params.require(:payment_collection).permit(
      :paymented_at,
      :child_id,
      payments_attributes: [:id, :item, :amount, :_destroy]
    )
  end
end
