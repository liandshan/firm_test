class Book < ApplicationRecord
    #   validates :username, presence: { message: "用户名不能为空" }
    #   validates :username, uniqueness: { message: "用户名已存在" }
    #   validates :password, presence: { message: "密码不能为空" }
    #   validates :password, length: { minimum: 6, message: "密码长度最短为6位" }
    attr_accessor :title, :describe, :book_type, :price, :published_at
   
    MY_BOOK=[
        {:title=>"台湾自助游参考手册",:describe=>"从此告别跟团的强制购物",:book_type=>1,:price=>50,:published_at=>"2014-01-01 01:01:01"},
        {:title=>"Ruby完全入自学册",:describe=>"Ruby入门必读精品",:book_type=>2,:price=>75,:published_at=>"2015-02-02 02:02:02"},
        {:title=>"军事基础",:describe=>"军事迷必备书籍",:book_type=>3,:price=>100,:published_at=>"2016-03-03 03:03:03"}
    ]

    def initialize(title,describe,book_type,price,published_at)
        @title=title
        @describe=describe
        @book_type=book_type
        @price=price
        @published_at=published_at 
    end    
    
    class << Book
        def create_some_books
          @b1=Book.new(MY_BOOK[0])
          @b2=Book.new(MY_BOOK[1])
          @b3=Book.new(MY_BOOK[2])
        end
        # 价位>=60元书的price总和
        def high_price_book_price
            price_total=0
            MY_BOOK.each do |book|
                if book[:price]>=60
                    price_total+=book[:price]
                end
            end 
            price_total
        end

        # 返回该年该月的月末值，比如month_begin_and_end(2016,2)，则返回29
        # 闰年：能被4整除但不能被100整除，或者能被400整除的数 
        def month_end(year,month)
            case month
            when 1,3,5,7,8,10,12
                return 31
            when 2
                if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
                    return 29
                else
                    return 28
                end
            when 4,6,9,11
                return 30
            else
                return "月份不合法"
            end
        end

        # 价位>=60元的书的平均价
        # 为0的，float型
        def avg_price
            price_total=0
            count=0
            MY_BOOK.each do |book|
                if book[:price]>=60
                    count+=1
                    price_total+=book[:price]
                end
            end 
            price_total/count.to_f
        end
    end

# 0<=price<60 低价位
# 60<= price <90 中价位
# price>= 90 高价位
    def price_level(price)
        if price>=0
            if  price<60
                return "低价位"
            elsif  price<90
                return "中价位"
            else
                return "高价位"
            end
        end
        return ""
    end

# 1 旅游类
# 2 技术类
# 3 军事类
    def type_name(book_type)
        case book_type
        when 1
            return "旅游类"
        when 2
            return "技术类"
        when 3
            return "军事类"
        else
            return ""
        end
    end

    # 2016年3月3日
    def published_at_cn(published_at)
        time1=Time.new(published_at)
        # time1.year.to_s+"年"+time1.month.to_s+"月"+time1.day.to_s+"日"
        "#{time1.year}年#{time1.month}月#{time1.day}日"
    end
end