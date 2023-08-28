class Contact < ApplicationRecord
  belongs_to :user

  validates :email, presence: true
  validates :content, presence: true
end
