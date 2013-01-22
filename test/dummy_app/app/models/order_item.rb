class OrderItem < ActiveRecord::Base

  acts_as_filterable :default_zero,  :quantity
  acts_as_filterable :default_price, :unit_price
  acts_as_filterable :integer_cast,  :total
  
  def sum_total
    quantity * unit_price
  end

end
