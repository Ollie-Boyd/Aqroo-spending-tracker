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
also_reload('./models/*')    

user = User.find_by_id(1)


get '/transactions' do
    @transactions = user.transactions_grouped_by_date__all_time()
    @years = user.array_of_prev_years()
    @months = user.merged_prev_months_and_month_ints()
    erb( :transactions)
end

get '/transactions/new' do
    @categories = Category.all()
    @merchants = user.merchants()
    erb( :new)
end

get '/transactions/:month/:year' do
    @transactions = user.transactions_grouped_by_date(params['month'].to_i, params['year'].to_i)
    @years = user.array_of_prev_years()
    @months = user.merged_prev_months_and_month_ints()
    erb(:transactions)
end


post '/transactions' do
    merchant_id = user.check_merchant(params['merchant_id'])
    transaction_hash = {'user_id' => user.id ,'transaction_date' => params[:transaction_date], 'merchant_id' => merchant_id, 'category_id' => params[:category_id], 'amount' => params[:amount]}
    transaction = Transaction.new(transaction_hash)
    transaction.save()
    redirect '/transactions'
end

post '/transactions/filter' do
    month = params['month']
    year = params['year']
    redirect "/transactions/#{month}/#{year}"
end

get '/profile' do
    @user = user
    @merchants = user.merchants()
    @categories = Category.all()
    erb (:profile)
end

get '/merchants/:id/edit' do
    @merchant = Merchant.find_by_id(params['id'])
    erb(:"merchants/edit")
end

post '/merchants/:id' do
    Merchant.new(params).update()   
    redirect '/profile'
end

get '/categories/:id/edit' do
    @category = Category.find_by_id(params['id'])
    erb(:"categories/edit")
end

post '/categories/:id' do
    Category.new(params).update()   
    redirect '/profile'
end


post '/categories' do
    category = Category.new(params)
    category.save()
    redirect '/profile'
end

get '/dashboard' do
    @this_month_percentage_spent = user.spending_as_percentage_of_income__current_month()
    @this_time_last_month_percentage_spent = user.spending_as_percentage_of_income__same_day_last_month()
    @line_graph_coords = user.get_x_y_graph_coords()
    @total_spend_this_month = user.total_spent_this_month().to_i
    @days_remaining_in_month = user.days_remaining_in_month().to_i
    @burn_rate = user.daily_burn_rate_current_month_excluding_bills().to_i
    @savings_goal = user.savings_goal().to_i

    erb(:dashboard)
end