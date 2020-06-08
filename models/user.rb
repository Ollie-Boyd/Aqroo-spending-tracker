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
        sql = "SELECT merchants.* FROM merchants
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
            user_transactions_grouped_hash = user_transactions.group_by{ |transaction| transaction.transaction_date()}           
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

end