class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: {greater_than: 0}
  validates :quantity, numericality: {greater_than_or_equal_to: 0}

  has_one_attached :image

  # search logic
  def self.search(name)
    if name.present?
      search_term = "%#{name.downcase}%"
      where("lower(name) LIKE ?", search_term)
    else
      order(created_at: :desc)
    end
  end

  # low stock logic
  def self.low_stock
    where("quantity <= ?", 10)
  end

  # increase stock
  def increase_stock(amount = 1)
    increment!(:quantity, amount.to_i)
  end

  def decrease_stock(amount = 1)
    decrement!(:quantity, amount.to_i)
  end
end
