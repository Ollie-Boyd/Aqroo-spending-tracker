require('sinatra')
require('sinatra/contrib/all')
require('byebug')     
require_relative('./models/sql_runner')
require_relative('./models/transaction')
require_relative('./models/sql_runner')
require_relative('./models/category')
require_relative('./models/fake_today')
require_relative('./models/user')
require_relative('./models/merchant')
require_relative('./db/seeds')
also_reload('./models/*')    

user_charlie = User.find_by_id(1)

get '/transactions' do
    @transactions = user_charlie.transactions_grouped_by_date()
    erb( :transactions)
end