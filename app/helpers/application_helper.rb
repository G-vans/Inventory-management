module ApplicationHelper
  def low_stock_class(product)
    (product.quantity <= 10) ? "bg-warning text-dark" : ""
  end
end
