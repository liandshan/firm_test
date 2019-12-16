# id	        integer	
# name	      string	
# brand	      string	
# category	  integer	
# price      	float	
# created_at	datetime	
# updated_at	datetime	

class Product < ApplicationRecord
  has_many:orders

  CATEGORY = [["笔记本",1],["PC主板",2],["手机",3],["平板",4]]

  scope :apple_products, -> { where( brand: '苹果')}
  # 返回分类的中文名称。
  def category_name
    CATEGORY.find{|s| s[1] == self.category}.try(:first)
  end

  # 返回一个价格
  def promote_price
      time=Time.now
      if time.month==11 && time.day==11
        return self.price*0.8 
      end
      return self.price
  end
end
