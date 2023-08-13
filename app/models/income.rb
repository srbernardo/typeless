class Income < ApplicationRecord
  belongs_to :user

  validates :date, :title, :value, presence: true
end
