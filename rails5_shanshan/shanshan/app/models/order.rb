# id	        integer	
# user_id	    integer	
# product_id	integer	
# num	        integer	
# batch_id	  string	
# created_at	datetime	
# updated_at	datetime

class Order < ApplicationRecord
  validates :user_id,presence: {message: '用户id不能为空'}
  validates :product_id,presence: {message: '产品id不能为空'}
  validates :num,presence: {message: '数量不能为空'}

  belongs_to :order_user ,:class_name => "User",:foreign_key => "user_id"
  belongs_to :order_production ,:class_name => "Product",:foreign_key => "product_id"
  

  class << self
    def vip_total_consumption
      sum=0
      lists=Order.joins(:order_user)
      lists.each do |data|
        if  data.order_user.present? && data.order_user.is_vip? 
          sum+=data.order_production[:price]
        end
      end
      return sum
    end
  end
end
