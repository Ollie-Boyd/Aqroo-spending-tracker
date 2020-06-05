require_relative('./sql_runner')
require_relative('./transaction')

class User

    attr_reader :id, :first_name, :last_name, :savings_goal, :monthly_income, :email 

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
        @savings_goal = options['savings_goal']
        @monthly_income = options['monthly_income']
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
        sql = "SELECT * FROM transactions WHERE transactions.user_id = $1"
        values = [@id]
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
            INNER JOIN transactions ON transactions.transaction_id = transaction.id
            WHERE transaction.user_id = $1;"
        values = [@id]
        retrieved_categories = SqlRunner.run(sql, values)
        retrieved_category_objects = Merchant.map_to_objects(retrieved_categories)
        return retrieved_category_objects
    end
end