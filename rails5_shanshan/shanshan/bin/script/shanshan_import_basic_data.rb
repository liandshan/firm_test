class AddBasicDatart
  # 或见lib/tasks/shanshan.rake文件,执行命令 $rake auth:add
  #该rb脚本执行命令$ rails r bin/script/shanshan_import_basic_data.rb
  users=[ 
    {:username=>"tom",:sex=>1},
    {:username=>"linda",:sex=>2},
    {:username=>"rose",:sex=>2},
    ]

  products=[
    {:name=>"s超极本",:brand=>"华硕",:category=>1,:price=>4288},
    {:name=>"X99主板",:brand=>"华硕",:category=>2,:price=>2888},
    {:name=>"iPhone6s",:brand=>"苹果",:category=>3,:price=>5288},
    {:name=>"iPhone6sPlus",:brand=>"苹果",:category=>3,:price=>6888},
    {:name=>"iPad Pro",:brand=>"苹果",:category=>4,:price=>6888},
    {:name=>"Mac Book Pro",:brand=>"苹果",:category=>1,:price=>9288},
  ]  

  users.each do |user|
    User.create({:username=>user[:username],:sex=>user[:sex]})
  end
   
  products.each do |product|
    Product.create({:name=>product[:name],:brand=>product[:brand],:category=>product[:category],:price=>product[:price]})
  end
end