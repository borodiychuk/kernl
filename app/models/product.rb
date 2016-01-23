class Product < ActiveRecord::Base

  belongs_to :project
  has_many :images
  has_many :product_prices
  has_many :product_variants

  scope :published, ->() { where :enabled => true }

  def prices
    Hash[product_prices.map{|p| [p.amount, p.price]}]
  end

end
