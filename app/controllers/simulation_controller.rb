class SimulationController < ApplicationController
  layout 'after_login_layout'
  def new
  end

  def create
    console.log(params[:selectedValues])
    render json: { message: 'Data received successfully.' }
  end
end
