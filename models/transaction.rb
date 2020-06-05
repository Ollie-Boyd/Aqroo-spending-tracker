
class Transaction

    attr_reader :id, :transaction_date, :merchant_id, :catagory_id, :amount
    
    def initialize(options)
        @id = options['id'].to_i if options['id']
        @transaction_date = options['transaction_date']
        @merchant_id = options['merchant_id']
        @category_id = options['category_id']
        @amount = options['amount']
    end

    def save()
      sql = "INSERT INTO transactions (transaction_date, merchant_id, category_id, amount) VALUES ($1, $2, $3, $4) RETURNING transactions.id"
      values = [@transaction_date, @merchant_id, @category_id, @amount]
      returned_id = SqlRunner.run(sql, values)[0]['id'].to_i
      @id = returned_id
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

    def self.map_to_objects(arr)
        return arr.map { |hash| Transaction.new(hash)}
    end 

end