class PaymentCollectionsController < ApplicationController
  layout 'after_login_layout'
  PLANS_COUNT = 3

  def index
    @payment_collections = @child.payment_collections.by_recently_paymented_at
    @stamps = @child.stamps
  end

  def new
    @payment_collection = PaymentCollection.new(paymented_at: Date.today)
    @payment_collection.get_payments_with_plans(@child)
  end

  def create
    @payment_collection = PaymentCollection.new(payment_collection_params)
    if @payment_collection.save
      @child.stamping(@payment_collection.paymented_at)
      redirect_to mypage_path(params[:child_id]), success: '入金しました'
    else
      flash.now[:danger] = '入金に失敗しました'
      render :new
    end
  end

  def edit
    @payment_collection = PaymentCollection.find(params[:id])
    (@payment_collection.payments.size...PLANS_COUNT).each { @payment_collection.payments.push(Payment.new) }
  end

  def update
    @payment_collection = @child.payment_collections.find(params[:id])
    if @payment_collection.update(payment_collection_params)
      @child.stamping(@payment_collection.paymented_at)
      redirect_to child_payment_collections_path(@child), success: '入金情報を編集しました'
    else
      flash.now[:danger] = '編集に失敗しました'
      render :edit
    end
  end

  def destroy
    payment_collection = @child.payment_collections.find(params[:id])
    payment_collection.destroy!
    @child.stamping(payment_collection.paymented_at)
    redirect_to child_payment_collections_path(@child), success: '入金情報を削除しました'
  end

  private

  def payment_collection_params
    params.require(:payment_collection).permit(
      :paymented_at,
      :child_id,
      payments_attributes: %i[id item amount _destroy]
    )
  end
end
