class Product < ApplicationRecord
    validates :name, presence: true
    validates :price, numericality: { greater_than: 0 }
    validates :quantity, numericality: { greater_than_or_equal_to: 0 }

    def low_stock
        quantity <= 10
    end
    
end
