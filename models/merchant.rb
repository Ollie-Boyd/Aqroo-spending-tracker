
class Merchant

    attr_reader :id, :name, :icon, :css_colour
    
    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @icon = options['icon']
        @css_colour = options['css_colour']
    end




end