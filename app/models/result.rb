class Result < ApplicationRecord
  belongs_to :child

  validates :age, presence: true
  validates :nursery_school, presence: true
  validates :kindergarten, presence: true
  validates :primary_school, presence: true
  validates :junior_high_school, presence: true
  validates :high_school, presence: true
  validates :university, presence: true
  validates :living_alone_funds, presence: true

  def self.params_format(result_params)
    age = result_params[:age]
    age == '出産前' ? result_params[:age] = 0 : result_params[:age] = age.to_i
    living_alone_funds = result_params[:living_alone_funds]
    living_alone_funds == '仕送りの予定はない' ? result_params[:living_alone_funds] = 0 : result_params[:living_alone_funds] = living_alone_funds.delete(',').to_i

    result_params
  end
end
