module Spree
  class Calculator::FlexibleWeightRate < Calculator
    preference :first_500g,      :decimal, :default => 0.0
    preference :additional_500g, :decimal, :default => 0.0

    attr_accessible :preferred_first_500g, :preferred_additional_500g

    def self.description
      "Flexible Weight Rate"
    end

    def self.available?(object)
      true
    end

    def compute(object)
      preferred_first_500g + additional_cost(object)
    end

    private
    def additional_cost(object)
      weight = object.total_weight || 1
      additionals = (weight / 500).to_i
      additionals -= 1 if (weight % 500 == 0)
      preferred_additional_500g * additionals
    end
  end
end
