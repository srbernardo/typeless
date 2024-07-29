class Income < ApplicationRecord
  belongs_to :user

  validates :date, :title, :value, presence: true

  def self.search_all_fields(query)
    where("description LIKE :query OR title LIKE :query OR value LIKE :query", query: "%#{query}%")
  end
end
