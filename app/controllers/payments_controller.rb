class PaymentsController < ApplicationController
  layout 'after_login_layout'
  def index
  end

  def new
    @payment = Payment.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
