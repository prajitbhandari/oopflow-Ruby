# require_relative 'Game.rb'
# require_relative 'Player.rb'
# require_relative 'Board.rb' 
# require_relative 'Move.rb'

class Main 
    def initialize
        @game = Game.new
        
        @p1 = Player.new('Player 1',"X")
        @p2 = Player.new('Player 2',"O")

        @boardSize = @game.askBoardSize
        @b = Board.new(@boardSize,@p1,@p2)
        @b.show
        @game.proceed
    end

end

obj=Main.new


