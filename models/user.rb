require_relative('./sql_runner')
require_relative('./transaction')
require_relative('./sql_runner')
require_relative('./category')
require_relative('./merchant')
require_relative('./fake_today')

class User

    attr_reader :id, :first_name, :last_name, :savings_goal, :monthly_income, :email 

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
        @savings_goal = options['savings_goal'].to_f
        @monthly_income = options['monthly_income'].to_f
        @email = options['email']
    end

    def save()
        sql = "INSERT INTO users (first_name, last_name, savings_goal, monthly_income, email) VALUES ($1, $2, $3, $4, $5) RETURNING users.id"
        values = [@first_name, @last_name, @savings_goal, @monthly_income, @email]
        returned_id = SqlRunner.run(sql, values)[0]['id'].to_i
        @id = returned_id
    end

    def delete()
        sql = "DELETE * FROM users WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)[0]
    end

    def update
        sql = "
            UPDATE users
            SET first_name = $1, last_name = $2, savings_goal = $3, monthly_income = $4, email = $5
            WHERE id = $6"
        values = [@first_name, @last_name, @savings_goal, @monthly_income, @email, @id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = 'DELETE FROM users;'
        SqlRunner.run(sql)
    end

    def self.all()
        sql = 'SELECT * FROM users;'
        retrieved_users = SqlRunner.run(sql)
        retrieved_user_objects = User.map_to_objects(retrieved_users)
        return retrieved_user_objects
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM users WHERE id = $1"
        values = [id]
        retrieved_user = SqlRunner.run(sql, values)[0]
        return User.new(retrieved_user)
    end

    def self.map_to_objects(arr)
        return arr.map { |hash| User.new(hash)}
    end

    def transactions()
        sql = "SELECT * FROM transactions WHERE transactions.user_id = $1 ORDER BY transactions.transaction_date DESC"
        values = [@id]
        retrieved_transactions = SqlRunner.run(sql, values)
        retrieved_transaction_objects = Transaction.map_to_objects(retrieved_transactions)
        return retrieved_transaction_objects
    end

    def transactions_by_month(month_number)
        sql = "SELECT * FROM transactions WHERE transactions.user_id = $1 AND EXTRACT( MONTH FROM transactions.transaction_date) = $2 ORDER BY transactions.transaction_date DESC"
        values = [@id, month_number]
        retrieved_transactions = SqlRunner.run(sql, values)
        retrieved_transaction_objects = Transaction.map_to_objects(retrieved_transactions)
        return retrieved_transaction_objects
    end

    def categories()
        sql = "SELECT categories.* FROM categories
            INNER JOIN transactions ON transactions.category_id = categories.id
            WHERE transactions.user_id = $1;"
        values = [@id]
        retrieved_categories = SqlRunner.run(sql, values)
        retrieved_category_objects = Category.map_to_objects(retrieved_categories)
        return retrieved_category_objects
    end

    def merchants()
        sql = "SELECT DISTINCT merchants.* FROM merchants
            INNER JOIN transactions ON transactions.merchant_id = merchants.id
            WHERE transactions.user_id = $1;"
        values = [@id]
        retrieved_categories = SqlRunner.run(sql, values)
        retrieved_category_objects = Merchant.map_to_objects(retrieved_categories)
        return retrieved_category_objects
    end

    def transactions_grouped_by_date(month=false) #takes an optional month parameter if we want a specific month
            user_transactions = transactions()
            user_transactions = transactions_by_month(month) if month.is_a? Integer
            user_transactions_grouped_hash = user_transactions.group_by{ |transaction| transaction.date_pretty()}

            return user_transactions_grouped_hash
    end


    def savings_goal_pretty()
        return sprintf "%.2f",@savings_goal
    end

    def monthly_income_pretty()
        return sprintf "%.2f",@monthly_income
    end

    def check_merchant(string)
        string_is_in_merchants_db = merchants().index{ |merchant| merchant.name.casecmp?(string)}
        if string_is_in_merchants_db.nil?
            new_merchant = Merchant.new({"name" => string})
            new_merchant.save()
            return new_merchant.id
        else
            return merchants()[string_is_in_merchants_db].id
        end
    end

    def days_so_far_in_month()
        days_so_far = current_date.day()
        return days_so_far
    end


    def get_date_range_transactions_including_bills(from, to)
        sql = "SELECT * FROM transactions WHERE transactions.user_id = $1 AND transaction_date >= $2 AND transaction_date <  $3 ORDER BY transactions.transaction_date DESC"
        values = [@id, from, to]
        retrieved_transactions = SqlRunner.run(sql, values)
        retrieved_transaction_objects = Transaction.map_to_objects(retrieved_transactions)
        return retrieved_transaction_objects
    end


    def sum_transactions(transaction_arr)
        transaction_amounts= transaction_arr.map{|transaction| transaction.amount()}
        return transaction_amounts.inject{|sum, transaction| sum + transaction}
    end





    def spending_as_percentage_of_income__current_month()
        current_date = FakeToday.now() 
        year = current_date.year()
        month = current_date.month()
        first_day_this_month = Date.parse("#{year}-#{month}-1") 


        this_months_transactions = get_date_range_transactions_including_bills(first_day_this_month, current_date)

        amount_spent_so_far = sum_transactions(this_months_transactions)

        income = @monthly_income

        return percentage = amount_spent_so_far/income * 100

    end


    def total_days_in_month(year, month)
        Date.new(year, month, -1).day
    end


    def spending_as_percentage_of_income__same_day_last_month()
        current_date = FakeToday.now() 
        day = current_date.day() 
        year = current_date.year()
        last_month = current_date.month()-1
        first_day_last_month = Date.parse("#{year}-#{last_month}-1") 


        total_days_last_month = total_days_in_month(year, last_month)

        #we don't want to tip into the next month's spending if the current month's number of calendar days is more than exist in this previous month. ie if this month has 31 days and last had 28
        end_day = day > total_days_last_month ? (total_days_last_month) : (day)
      
        last_date_in_range = Date.parse("#{year}-#{last_month}-#{end_day}") 
        
        last_months_transactions = get_date_range_transactions_including_bills(first_day_last_month, last_date_in_range)

        amount_spent_this_time_last_month = sum_transactions(last_months_transactions)

        income = @monthly_income

        return percentage = amount_spent_this_time_last_month/income * 100
    end

    def get_x_y_graph_coords() 
        current_date = FakeToday.now() #refactor
        day = current_date.day() 
        year = current_date.year()
        month = current_date.month()
        first_day_this_month = Date.parse("#{year}-#{month}-1") 
        array_of_dates = (first_day_this_month..current_date).to_a
        hash_of_dates = array_of_dates.map{ |date| [ date, [0] ] }.to_h
        
        this_months_transactions = transactions_grouped_by_date(month)

        combined_hashes_with_spending = hash_of_dates.merge(this_months_transactions){|key, blank_arr, transactions| [blank_arr, transactions.map{|transaction| transaction.amount()}].flatten}  #refactor to make readable
        array_with_spending = combined_hashes_with_spending.map{|k,v| v }
        
        array_with_summed_spending = array_with_spending.map{|spends| spends.inject(:+) }
        
        array_with_summed_spending_as_percent_of_monthly_salary = array_with_summed_spending.map{|spend| spend/@monthly_income * 100 }
        
        starting_graph_percentage_y_axis = 0
        y_axis_reducing_value = array_with_summed_spending_as_percent_of_monthly_salary.map{|day_spend| starting_graph_percentage_y_axis+=day_spend}
        
        days_in_month = total_days_in_month(year, month)
        days_as_percentage = (100.0/days_in_month).round(4)

        day_percentages_as_arr = days_as_percentage.step(by: days_as_percentage).take(day)
        
        combined_x_y_percentages = day_percentages_as_arr.zip(y_axis_reducing_value)
        
       return combined_x_y_percentages.prepend([0.0,0.0])

    end




end