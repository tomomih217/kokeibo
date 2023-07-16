class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :children

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  # 新規登録かパスワード変更の時に以下のバリデーションを適用する。
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def self.duplicated?(name)
    User.find_by(name: name).present?
  end

  def current_child
    children.first
  end
end
