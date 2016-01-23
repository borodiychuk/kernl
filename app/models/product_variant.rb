class ProductVariant < ActiveRecord::Base

  belongs_to :product

  default_scope ->() { order("name ASC")}

end
