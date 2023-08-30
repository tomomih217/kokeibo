class Contact < ApplicationRecord
  belongs_to :user

  validates :email, presence: true, length: { maximum: 65_535 }
  validates :content, presence: true, length: { maximum: 65_535 }
end
