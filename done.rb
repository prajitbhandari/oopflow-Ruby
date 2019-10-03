require_relative 'test.rb'


class Done
    def initialize
        @t=Test.new('Prajit',23)
        self.show
    end

    def show
        puts "My name is "+@t.name
    end

    

end

d=Done.new