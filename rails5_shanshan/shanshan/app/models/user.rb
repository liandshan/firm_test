# id	        integer	
# username	  string	
# sex	        integer	
# created_at	datetime	
# updated_at	datetime

class User < ApplicationRecord
  validates :username,uniqueness: {message: '用户名已存在'}

  has_many:orders,dependent: :destroy

  VIP_USER = ["tom"]
  def is_vip?
    VIP_USER.each do |s|
       if s== self.username
        return true 
       end
    end
    return false 
  end
end
