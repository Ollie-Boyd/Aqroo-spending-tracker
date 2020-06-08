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
    @transactions = user.transactions_grouped_by_date()
    erb( :transactions)
end

get '/transactions/new' do
    @categories = Category.all()
    @merchants = user.merchants()
    erb( :new)
end

post '/transactions' do
    merchant_id = user.check_merchant(params[:merchant_id])
    transaction_hash = {'user_id' => user.id ,'transaction_date' => params[:transaction_date], 'merchant_id' => merchant_id, 'category_id' => params[:category_id], 'amount' => params[:amount]}
    transaction = Transaction.new(transaction_hash)
    transaction.save()
    redirect '/transactions'
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

get '/dashboard' do
    erb(:dashboard)
end