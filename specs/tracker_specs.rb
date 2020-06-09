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

p user_charlie.total_spent_this_month()
p user_charlie.savings_goal()
p user_charlie.transactions_by_month__excluding_bills(6)
p user_charlie.spending_current_month_excluding_bills()
p user_charlie.daily_burn_rate_current_month_excluding_bills()



