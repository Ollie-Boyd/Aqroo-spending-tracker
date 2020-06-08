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


current_date = FakeToday.now() 
year = current_date.year()
month = current_date.month()
first_day_this_month = Date.parse("#{year}-#{month}-1")

p user_charlie.create_hash_of_days_in_month_so_far()



