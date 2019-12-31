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
  after_create :add_order_batch_id
  # belongs_to :order_user ,:class_name => "User",:foreign_key => "user_id"
  # belongs_to :order_production ,:class_name => "Product",:foreign_key => "product_id"
  
  belongs_to :user  
  belongs_to :product
  

  class << self
    def vip_total_consumption
      Order.select{|order| order.user.is_vip?}.map{|order| order.product[:price]}.sum
      # sum=0
      # lists=Order.joins(:order_user)
      # lists.each do |data|
      #   if  data.order_user.present? && data.order_user.is_vip? 
      #     sum+=data.order_production[:price]
      #   end
      # end
      # return sum
    end
  end

  # 自动添加订单的batch_id（batch_id的命名规则是：日期信息_用户id_四位流水号，例如：20160322_1_0001）
  def add_order_batch_id
    puts "===================================="
    self.batch_id="#{Time.now.strftime("%Y%m%d")}_#{self.user_id}_#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}"
    self.save!
  end
end
