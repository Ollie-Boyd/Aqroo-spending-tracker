require_relative('./sql_runner')
require_relative('./transaction')
require_relative('./sql_runner')
require_relative('./merchant')
require_relative('./fake_today')
require_relative('./user')

class Category

    attr_reader :id, :name, :icon, :css_colour
    
    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @icon = options['icon']
        @css_colour = options['css_colour']
    end

    def save()
        sql = "INSERT INTO categories (name, icon, css_colour) VALUES ($1, $2, $3) RETURNING categories.id"
        values = [@name, @icon, @css_colour]
        returned_id = SqlRunner.run(sql, values)[0]['id'].to_i
        @id = returned_id
    end

    def delete()
        sql = "DELETE * FROM categories WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)[0]
    end

    def update
        sql = "
            UPDATE categories
            SET name = $1, icon = $2, css_colour = $3
            WHERE id = $4"
        values = [@name, @icon, @css_colour, @id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = 'DELETE FROM categories;'
        SqlRunner.run(sql)
    end

    def self.all()
        sql = 'SELECT * FROM categories;'
        retrieved_categories = SqlRunner.run(sql)
        retrieved_category_objects = Category.map_to_objects(retrieved_categories)
        return retrieved_category_objects
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM categories WHERE id = $1"
        values = [id]
        retrieved_category = SqlRunner.run(sql, values)[0]
        return Category.new(retrieved_category)
    end

    def self.map_to_objects(arr)
        return arr.map { |hash| Category.new(hash)}
    end
    
end