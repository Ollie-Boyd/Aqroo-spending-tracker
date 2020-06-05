require_relative('./sql_runner')
require_relative('./transaction')
require_relative('./sql_runner')
require_relative('./category')
require_relative('./fake_today')
require_relative('./user')

class Merchant

    attr_reader :id, :name

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
    end

    def save()
        sql = "INSERT INTO merchants (name) VALUES ($1) RETURNING merchants.id"
        values = [@name]
        returned_id = SqlRunner.run(sql, values)[0]['id'].to_i
        @id = returned_id
    end

    def delete()
        sql = "DELETE * FROM merchants WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)[0]
    end

    def update
        sql = "
            UPDATE merchants
            SET name = $1
            WHERE id = $2"
        values = [@name, @id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = 'DELETE FROM merchants;'
        SqlRunner.run(sql)
    end

    def self.all()
        sql = 'SELECT * FROM merchants;'
        retrieved_merchants = SqlRunner.run(sql)
        retrieved_merchant_objects = Merchant.map_to_objects(retrieved_merchants)
        return retrieved_merchant_objects
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM merchants WHERE id = $1"
        values = [id]
        retrieved_merchant = SqlRunner.run(sql, values)[0]
        return Merchant.new(retrieved_merchant)
    end

    def self.map_to_objects(arr)
        return arr.map { |hash| Merchant.new(hash)}
    end 

end