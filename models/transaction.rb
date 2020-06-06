require_relative('./sql_runner')
require_relative('./sql_runner')
require_relative('./category')
require_relative('./merchant')
require_relative('./fake_today')
require_relative('./user')

class Transaction

    attr_reader :id, :transaction_date, :merchant_id, :category_id, :amount, :user_id
    
    def initialize(options)
        @id = options['id'].to_i if options['id']
        @transaction_date = Date.parse(options['transaction_date'])
        @merchant_id = options['merchant_id']
        @category_id = options['category_id']
        @amount = options['amount'].to_f
        @user_id = options['user_id'].to_i
    end

    def save()
        sql = "INSERT INTO transactions (transaction_date, merchant_id, category_id, amount, user_id) VALUES ($1, $2, $3, $4, $5) RETURNING transactions.id"
        values = [@transaction_date, @merchant_id, @category_id, @amount, @user_id]
        returned_id = SqlRunner.run(sql, values)[0]['id'].to_i
        @id = returned_id
    end

    def amount_pretty()
        return sprintf "%.2f",@amount
    end

    def delete()
        sql = "DELETE * FROM transactions WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)[0]
    end

    def update
        sql = "
            UPDATE transactions
            SET transaction_date = $1, merchant_id = $2, category_id = $3, amount = $4
            WHERE id = $5"
        values = [@transaction_date, @merchant_id, @category_id, @amount, @id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = 'DELETE FROM transactions;'
        SqlRunner.run(sql)
    end

    def self.all()
        sql = 'SELECT * FROM transactions;'
        retrieved_transactions = SqlRunner.run(sql)
        retrieved_transaction_objects = Merchant.map_to_objects(retrieved_transactions)
        return retrieved_transaction_objects
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM transactions WHERE id = $1"
        values = [id]
        retrieved_transaction = SqlRunner.run(sql, values)[0]
        return Transaction.new(retrieved_transaction)
    end

    def merchant()
        sql = "SELECT * FROM merchants WHERE id = $1"
        values = [@merchant_id]
        retrieved_merchant = SqlRunner.run(sql, values)[0]
        return Merchant.new(retrieved_merchant)
    end

    def category()
        sql = "SELECT * FROM categories WHERE id = $1"
        values = [@category_id]
        retrieved_category = SqlRunner.run(sql, values)[0]
        return Category.new(retrieved_category)
    end

    def self.map_to_objects(arr)
        return arr.map { |hash| Transaction.new(hash)}
    end 

end