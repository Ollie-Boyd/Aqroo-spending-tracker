
class Transaction

    attr_reader :id, :transaction_date, :merchant_id, :catagory_id, :amount
    
    def initialize(options)
        @id = options['id'].to_i if options['id']
        @transaction_date = options['transaction_date']
        @merchant_id = options['merchant_id']
        @category_id = options['category_id']
        @amount = options['amount']
    end

    def self.map_to_objects(arr)
      return arr.map { |hash| Transaction.new(hash)}
    end


end