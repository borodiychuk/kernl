class ProductPrice < ActiveRecord::Base

  belongs_to :product

  default_scope ->() { order("amount ASC")}

end
