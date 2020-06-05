class FakeToday


    def initialize(date)
        @now = date
    end
    
    def now()
        return @now
    end



# You can use to_s(:db) to convert into a database friendly format.

# Time.now.to_s(:db)

# However, be careful if you have a timezone specified in Rails because the time will be stored in UTC in the database. You'll need to specify that to do proper comparisons.

# Time.now.utc.to_s(:db)

# You can also use NOW() function in MySQL instead of generating the current time in Ruby.


end