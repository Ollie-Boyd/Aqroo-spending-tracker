require_relative('./sql_runner')

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

    def 

    def self.delete_all()
        sql = 'DELETE FROM users;'
        SqlRunner.run(sql)
    end

    def self.all()
        sql = 'SELECT * FROM users;'
        returned = SqlRunner.run(sql)
        returned_as_arr_of_objects = User.map_to_objects(returned)
        return returned_as_arr_of_objects
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM user WHERE id = $1"
        values = [id]
        returned_user = SqlRunner.run(sql, values)[0]
        return User.new(returned_user)
    end

    def self.map_to_objects(arr)
        return arr.map { |hash| User.new(hash)}
    end




end