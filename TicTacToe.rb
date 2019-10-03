class Game
    def initialize
        # set up the players
        @p1 = Player.new('Player 1',"X")
        @p2 = Player.new('Player 2',"O")
        # set up the board
        
        @bSize = self.askBoardSize.to_i
        @b = Board.new(@bSize,@p1,@p2)
               
        self.proceed
         
    end
    
    def askBoardSize
    #   prompt board size form user
        puts "Enter the size of the Board Grid"
        @size=(gets.chomp).to_i
        puts "The Board size is #{@size}"
        return @size
    end

    def proceed
        puts "Player object is #{@p2.inspect}"
        puts "You Proceed"
        puts "Hello There"
        unless self.ended?
            puts "Check Here"
            self.handleNextMove
        else
            puts "Check Else"
            self.showResult
        end
    end
    def ended?
        puts "The b object is #{@b.inspect}"
        self.gameIsWon?
        # ||@b.gameIsDraw?
    end
    
    def gameIsWon?
        
        # referencePlayer
        # referencePlayerMoves
        self.leftDiagonal(@board,@board_size)
        # self.rightDiagonal(@b.board,@b.board_size)
        # self.checkRow(@b.board,@b.board_size)
        # self.checkColumn(@b.board,@b.board_size)
    end
    
    # def gameIsDraw?
    #     if(!gameIsWon?)
    #         return true
    #     end
    # end

    def handleNextMove
        @@a=1
        if(@@a%2!=0)
            puts "Player #{@identifer} turn"
            @p1.move_token="X"
            @p1.askNextMove
        else 
            puts "Player #{@identifier} turn"
            @p2.move_token="O"
            @p2.askNextMove
        end
        @@a+=1
    end

    def leftDiagonal(board,board_size)
        lcount=1;
        for i in 0...(@b.board_size-1) do
            for j in 0...(@b.board_size-1) do
                if(i== j)
                    if((@b.board[i][j]==@b.board[i+1][j+1]))
                        lcount=lcount+1;
                        if(lcount==@b.board_size)
                            return @identifier
                            return true;
                            break;
                        end	
                    end
                end		
            end												
        end
    end

    # def rightDiagonal(board,board_size)
    #     rcount=1;
    #     for i in 0...(@b.board_size-1) do
    #         for j in 0..(@b.board_size-1)  do
    #             if(i+j==@b.board_size-1)
    #                 if(@b.board[i][j]!="")
    #                     if((@b.board[i][j]==@b.board[i+1][j-1]))
    #                         rcount=rcount+1;
    #                         if(rcount==@b.board_size)
    #                             return self.identifier
    #                             break;
    #                         end	
    #                     end
    #                 end
    #             end		         
    #         end
    #     end
    # end

    # def checkRow(board,board_size)
    #     xcount=1;
    #     ycount=1;
    #     for i in 0..(@b.board_size-1) do
    #         for j in 0...(@b.board_size-1) do
    #             if((@b.board[i][j]=="X" && @b.board[i][j+1]=="X"))      
    #                 xcount=xcount+1;
    #                 puts xcount
    #                 if(xcount==@b.board_size)
    #                     return self.identifier
    #                     break;
    #                 end 
    #             elsif((@b.board[i][j]=="O" && @b.board[i][j+1]=="O"))  
    #                 ycount=ycount+1;
    #                 puts ycount
    #                 if(ycount==@b.board_size)
    #                     return self.identifier
    #                     return true;
    #                     break;
    #                 end
    #             end
    #         end
    #         xcount=1;
    #         ycount=1;
    
    #     end
    # end
    
    # def checkColumn(board,board_size)
    #     xcount=1;
    #     ycount=1;
    #     for i in 0..(@b.board_size-1) do
    #         for j in 0...(@b.board_size-1) do
    #             if((@b.board[j][i]=="X" && @b.board[j+1][i]=="X"))    
    #                 xcount=xcount+1;
    #                 if(xcount==@b.board_size)
    #                     return self.identifier
    #                     return true;
    #                     break;
    #                 end
    #             elsif((@b.board[j][i]=="O" && @b.board[j+1][i]=="O"))  
    #                 ycount=ycount+1;
    #                 if(ycount==@b.board_size)
    #                     return self.identifier                       
    #                     return true;
    #                     break;
    #                 end																								
    #             end
    #         end
    #         xcount=1;
    #         ycount=1;												
    
    #     end
    
    # end

    def showResult   
        if(gameIsWon?)
            puts "Player #{@identifer} wins"
            exit
        elsif(gameIsDraw?)
            puts "Game is Tied"
        end
    end
end


class Player
    attr_accessor :identifier,:move_token
    
    def initialize(identifier,move_token)
        @identifier=identifier
        @move_token=move_token
    end
    
    def askNextMove
        # newUserMove //
        puts "Enter the move_mark at available Array index [][]"
        row= (gets.chomp).to_i
        col= (gets.chomp).to_i 
        obj= Move.new(row, col)
        registerMove(obj)
    end
       
    def registerMove(obj)
        @board[obj.row][obj.col]=@move_token
    end

end

class Board
    attr_accessor :board,:board_size

    def initialize(board_size,p1,p2)
        @board_size= board_size
        @board=[]
        for i in 0...(@board_size) do
          @board.push(["",""])
        end
        @p1=p1
        @p2=p2
        
    end
    
    def show
        puts "Welcome to Tic Tac Toe Game"
        puts "The Player is #{@p1.identifier} and move token is #{@p1.move_token}"
        puts "The Opponent Player is #{@p2.identifier} and move token is #{@p2.move_token}"

        for x in 0...(self.board_size) do
            for y in 0...(self.board_size) do
                print x,y
                if (y != self.board_size-1) 
                    print "  |   "
                end
            end
       
            if (x != self.board_size-1)
                print "\n"
                for i in 0...(self.board_size + (self.board_size * 3)) do
                    print "="
                end
                print "\n"
            else 
                print "\n"
            end
        end
    end
    
end

class  Move
    attr_accessor :row,:col
    
    def initialize(x,y) 
     @row=x
     @col=y
    end
end


@game1=Game.new

