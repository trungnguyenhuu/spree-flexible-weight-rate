Spree::Order.class_eval do
  def total_weight
    line_items.reduce(0) { |sum, li| sum += li.total_weight }
  end
end
