class UserForm
  include ActionModel::Model

  attr_accessor :username, :password, :password_confirmation, :term_of_service

  validates :username, presence: true, length: { maxmum: 255 }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :term_of_service, presence: true
  
  delegate :presisted?, to: :user

  def initialize(attributes = nil, user: User.new)
    @user = user
    attributes ||= default_attributes
    super(attributes)
  end

  def save
  end

  def to_model
    user
  end

  private

  attr_reader :user

  def default_attributes
    {
      username: user.username,
      password: user.password,
      password_confirmation: user.password_confirmation,
      term_of_service: false
    }
  end
end