
require('date')

class FakeToday


    
    def initialize()
        
    end
    
    def self.now()
        return Date.parse("2020-06-11")
    end

end