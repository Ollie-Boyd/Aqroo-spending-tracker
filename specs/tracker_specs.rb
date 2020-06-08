require('minitest') 
require('byebug')     
require_relative('../models/sql_runner')
require_relative('../models/transaction')
require_relative('../models/sql_runner')
require_relative('../models/category')
require_relative('../models/fake_today')
require_relative('../models/user')
require_relative('../models/merchant')



user_charlie = User.find_by_id(1)

p user_charlie.days_so_far_in_month()



