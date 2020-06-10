require_relative('./sql_runner')
require_relative('./transaction')
require_relative('./sql_runner')
require_relative('./category')
require_relative('./merchant')
require_relative('./fake_today')


class User

    attr_reader :id, :first_name, :last_name, :savings_goal, :monthly_income, :email

    @@current_date = FakeToday.now()
    @@current_day = FakeToday.now.day()
    @@current_month = FakeToday.now.month()
    @@current_year = FakeToday.now.year()

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

    def daily_burn_rate_current_month_excluding_bills()
        spent = spending_current_month_excluding_bills()
        days_so_far = days_so_far_in_month()
        return spent/days_so_far
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

    def first_day_in_month(month, year)
        return Date.parse("#{year}-#{month}-1") 
    end

    def last_day_in_month(month, year)
       final_day = total_days_in_month(month, year)
        return  Date.parse("#{year}-#{month}-#{final_day}") 
    end
    
    def spending_current_month_excluding_bills()
       
        from = first_day_in_month(@@current_month, @@current_year)
        to = last_day_in_month(@@current_month, @@current_year)

        transactions_arr = get_date_range_transactions_excluding_bills(from, to)
        return sum_transactions(transactions_arr)
    end

    def transactions_grouped_by_date__all_time() #takes an optional month & year parameter if we want a specific month #need to fix to include year duh!!
        user_transactions = transactions()
        user_transactions_grouped_hash = group_transactions_by_date(user_transactions)
        user_transactions_grouped_hash_sorted = user_transactions_grouped_hash.each{ |_,arr| arr.sort_by{|arr| arr.timestamp()} }
        return user_transactions_grouped_hash
    end

    def group_transactions_by_date(transaction_arr)
     return transaction_arr.group_by{ |transaction| transaction.transaction_date()}
    end

    def transactions_grouped_by_date(month, year) 
        user_transactions = transactions()

        from = first_day_in_month(month, year)
        to = last_day_in_month(month, year)
        user_transactions = get_date_range_transactions_including_bills(from, to) 
        user_transactions_grouped_hash = group_transactions_by_date(user_transactions)
        user_transactions_grouped_hash_sorted = user_transactions_grouped_hash.each{ |_,arr| arr.sort_by{|arr| arr.timestamp()} }
        return user_transactions_grouped_hash
    end


    def get_date_range_transactions_including_bills(from, to)
        sql = "SELECT * FROM transactions WHERE transactions.user_id = $1 AND transaction_date >= $2 AND transaction_date <  $3 ORDER BY transactions.transaction_date DESC"
        values = [@id, from, to]
        retrieved_transactions = SqlRunner.run(sql, values)
        retrieved_transaction_objects = Transaction.map_to_objects(retrieved_transactions)
        return retrieved_transaction_objects
    end

    def get_date_range_transactions_excluding_bills(from, to)
        sql = "SELECT * FROM transactions WHERE transactions.user_id = $1 AND transaction_date >= $2 AND transaction_date <  $3 AND transactions.category_id <> $4 ORDER BY transactions.transaction_date DESC"
        values = [@id, from, to, 8] #warning hardcoding the category id, in the future, the categories won't be editable by user.
        retrieved_transactions = SqlRunner.run(sql, values)
        retrieved_transaction_objects = Transaction.map_to_objects(retrieved_transactions)
        return retrieved_transaction_objects
    end

    def spending_as_percentage_of_income__current_month()
        
        first_day_in_month = first_day_in_month(@@current_month, @@current_year)


        this_months_transactions = get_date_range_transactions_including_bills(first_day_in_month, @@current_date)

        amount_spent_so_far = sum_transactions(this_months_transactions)

        income = @monthly_income

        return percentage = amount_spent_so_far/income * 100

    end

    def total_spent_this_month()
        from = first_day_in_month(@@current_month, @@current_year)
        to = last_day_in_month(@@current_month, @@current_year)
        transaction_arr = get_date_range_transactions_including_bills(from, to)
        return sum_transactions(transaction_arr)
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
        days_so_far = FakeToday.now.day()
        return days_so_far
    end

    def sum_transactions(transaction_arr)
        transaction_amounts= transaction_arr.map{|transaction| transaction.amount()}
        return transaction_amounts.inject{|sum, transaction| sum + transaction}
    end

    def total_days_in_month(month, year)
        Date.new(year, month, -1).day
    end

    def days_remaining_in_month()
        return total_days_in_month(FakeToday.now.month, FakeToday.now.year)-days_so_far_in_month()
    end

    def spending_as_percentage_of_income__same_day_last_month()
        one_month_ago = @@current_date <<  1
        one_month_ago_year = one_month_ago.year()
        one_month_ago_month = one_month_ago.month()
        first_day_last_month = Date.parse("#{one_month_ago_year}-#{one_month_ago_month}-1") 

        total_days_last_month = total_days_in_month(one_month_ago_month, one_month_ago_year)

        #we don't want to tip into the next month's spending if the current month's number of calendar days is more than exist in this previous month. ie if this month has 31 days and last had 28
        end_day = @@current_day > total_days_last_month ? (total_days_last_month) : (@@current_day)
      
        last_date_in_range = Date.parse("#{one_month_ago_year}-#{one_month_ago_month}-#{end_day}") 
        
        last_months_transactions = get_date_range_transactions_including_bills(first_day_last_month, last_date_in_range)

        amount_spent_this_time_last_month = sum_transactions(last_months_transactions)

        income = @monthly_income

        return percentage = amount_spent_this_time_last_month/income * 100
    end

    def get_x_y_graph_coords() 
        first_day_in_month = Date.parse("#{@@current_year}-#{@@current_month}-1") 
        array_of_dates = (first_day_in_month..@@current_date).to_a
        hash_of_dates = array_of_dates.map{ |date| [ date, [0] ] }.to_h

        
        this_months_transactions = transactions_grouped_by_date(@@current_month, @@current_year) 

        combined_hashes_with_spending = hash_of_dates.merge(this_months_transactions){|key, blank_arr, transactions| [blank_arr, transactions.map{|transaction| transaction.amount()}].flatten}  #refactor to make readable
        array_with_spending = combined_hashes_with_spending.map{|k,v| v }
        
        array_with_summed_spending = array_with_spending.map{|spends| spends.inject(:+) }
        
        array_with_summed_spending_as_percent_of_monthly_salary = array_with_summed_spending.map{|spend| spend/@monthly_income * 100 }
        
        starting_graph_percentage_y_axis = 0
        y_axis_increasing_value = array_with_summed_spending_as_percent_of_monthly_salary.map{|day_spend| starting_graph_percentage_y_axis+=day_spend}
        
        days_in_month = total_days_in_month(@@current_month, @@current_year)

        days_as_percentage_along_x_axis = (100.0/days_in_month).round(4)

        day_percentages_as_arr = days_as_percentage_along_x_axis.step(by: days_as_percentage_along_x_axis).take(@@current_day)
        
        combined_x_y_percentages = day_percentages_as_arr.zip(y_axis_increasing_value)
        
        return combined_x_y_percentages.prepend([0.0,0.0])
    end

    def array_of_prev_months()
        date_to = @@current_date
        date_from = @@current_date << 11
        date_range = date_from..date_to        
        arr_months = date_range.map {|d| d.strftime "%B"}.uniq
    end

    def array_of_prev_years()
        earliest_transaction_year = transactions().map{|transaction| transaction.transaction_date().year()}.min()       
        return (earliest_transaction_year..@@current_year).to_a
    end
end