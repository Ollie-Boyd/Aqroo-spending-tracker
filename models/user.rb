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
        values = [@first_name, @last_name, @savings_goal, @monthly_income, @email]
        SqlRunner.run(sql, values)
    end


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
        sql = "SELECT * FROM users WHERE id = $1"
        values = [id]
        returned_user = SqlRunner.run(sql, values)[0]
        return User.new(returned_user)
    end

    def self.map_to_objects(arr)
        return arr.map { |hash| User.new(hash)}
    end

end