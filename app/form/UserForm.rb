class UserForm
  # ActiveModel::Attributeは既にincludeされているので不要
  include ActiveModel::Model

  # 属性を設定
  attr_accessor :name, :password, :password_confirmation, :term_of_service

  # バリデーションを設定
  validates :name, presence: true, length: { maximum: 255 }
  validates :password, presence: true
  validates :password, confirmation: true # passwordとpassword_confirmationが同じか判定
  validates :password_confirmation, presence: true
  validates :term_of_service, acceptance: true # term_of_serviceの値がtrueかどうかを判定
  
  # Userのpersisted?を委譲し、createかupdateかを判断
  delegate :presisted?, to: :user

  # attributesの初期化
  def initialize(attributes = nil, user: User.new)
    @user = user
    attributes ||= default_attributes
    super(attributes)
  end

  # データベースへ保存
  def save
    return if invalid?
    
    user.update!(name: name, password: password, password_confirmation: password_confirmation)
  rescue ActiveRecord::RecordInvalid
    false
  end

  # form_withで必要。POSTかPATCHかを判断する
  def to_model
    user
  end

  private

  attr_reader :user

  # もしattributesがnil（変更しない属性)ならば保存済みの値を入力
  def default_attributes
    {
      name: user.name,
      password: user.password,
      password_confirmation: user.password_confirmation,
      term_of_service: true
    }
  end
end