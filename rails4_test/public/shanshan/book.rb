class Book 
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

    # title:"台湾自助游参考手册",describe:"从此告别跟团的强制购物",book_type:1,price:50,published_at:"2014-01-01 01:01:01"
    # ["台湾自助游参考手册","从此告别跟团的强制购物",1,50,"2014-01-01 01:01:01"]
    # Book.new()的时候自动调用初始化方法
    def initialize(title,describe,book_type,price,published_at)
        @title=title
        @describe=describe
        @book_type=book_type
        @price=price
        @published_at=published_at 
    end    
    
    class << Book
        def create_some_books
          @b1=Book.new(MY_BOOK[0][:title],MY_BOOK[0][:describe],MY_BOOK[0][:book_type],MY_BOOK[0][:price],MY_BOOK[0][:published_at])
          @b2=Book.new(MY_BOOK[1][:title],MY_BOOK[1][:describe],MY_BOOK[1][:book_type],MY_BOOK[1][:price],MY_BOOK[1][:published_at])
          @b3=Book.new(MY_BOOK[2][:title],MY_BOOK[2][:describe],MY_BOOK[2][:book_type],MY_BOOK[2][:price],MY_BOOK[2][:published_at])
        end
        
        # 价位>=60元书的price总和
        def high_price_book_price
            MY_BOOK.select{|b| b[:price]>=60}.map{|b| b[:price]}.sum
        end

        # 返回该年该月的月末值，比如month_begin_and_end(2016,2)，则返回29
        # 闰年：能被4整除但不能被100整除，或者能被400整除的数 
        def month_end(year,month)
           return 31 if [1,3,5,7,8,10,12].include?(month)
           return 30 if [4,6,9,11].include?(month)
           if month.to_i==2
            return 29 if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
            return 28
           end     
           "月份不合法"
            
        end

        # 价位>=60元的书的平均价
        # 为0的，float型
        def avg_price
            high_price_book_price.to_f/ MY_BOOK.select{|b| b[:price]>=60}.map{|b| b[:price]}.size
        end
    end

# 0<=price<60 低价位
# 60<= price <90 中价位
# price>= 90 高价位
    def price_level
        return '低价位' if price>=0 && price<60
        return '中价位' if price>=60 && price<90
        return '高价位' if price>=90
    end

# 1 旅游类
# 2 技术类
# 3 军事类
    def type_name
        case self.book_type
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
    def published_at_cn
        Time.new(published_at).strftime("%Y年%m月%d日")
    end
end