require('minitest') 
require('byebug')     
require_relative('../models/sql_runner')
require_relative('../models/transaction')
require_relative('../models/sql_runner')
require_relative('../models/category')
require_relative('../models/fake_today')
require_relative('../models/user')
require_relative('../models/merchant')
require_relative('../db/seeds')


user_charlie = User.find_by_id(1)


p user_charlie.transactions_grouped_by_date(5)

