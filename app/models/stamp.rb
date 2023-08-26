class Stamp < ApplicationRecord
  belongs_to :child

  enum status: { unpayed: 0, payed: 1, complete: 2 }
end

