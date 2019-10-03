require_relative 'Move.rb'

class Player
    attr_accessor :identifier,:move_token
    
    def initialize(identifier,move_token)
        
        @identifier=identifier
        @move_token=move_token
    end
    
    def askNextMove
        # newUserMove //
        puts "Enter the move_mark at available Array index [][]"
        @row= (gets.chomp).to_i
        @col= (gets.chomp).to_i 
        @obj= Move.new(@row,@col)
        # registerMove(@obj)
    end
       
    # def registerMove(obj)
    #      @board[obj.row][obj.col]=self.move_token
    # end
end
