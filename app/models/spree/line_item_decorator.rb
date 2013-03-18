Spree::LineItem.class_eval do
  def total_weight
    quantity * (variant.weight || 1)
  end
end
