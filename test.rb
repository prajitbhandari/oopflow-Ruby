require_relative 'Board.rb'
class Game
    def initialize
        @p1 = Player.new('Player 1',"X")
        @p2 = Player.new('Player 2',"O")
        @boardSize = self.askBoardSize
        @b = Board.new(@boardSize,@p1,@p2)
        @b.show
        self.proceed
    end
    
    def askBoardSize
        puts "Welcome to Tic Tac Toe Game"
    #   prompt board size form user
        puts "Enter the size of the Board Grid"
        @size=(gets.chomp).to_i
        # puts "The Board size is #{@size}"
        return @size
    end

    def proceed
        puts " "
        puts "First Proceed Player #{@p1.identifier} turn"
        puts "Place #{@p1.move_token}"
        puts ""
        @objx=@p1.askNextMove

        if(@objx.row>=@b.board_size||@objx.col>=@b.board_size)
            puts " "
            puts "Choose valid row and column"
            self.proceed
        end
        @b.board[@objx.row][@objx.col]=@p1.move_token 
        # puts "Now currently obj b is #{@b.inspect}"       
        @b.printBoard

        @@a=2
        @@draw_counter=0
        #pseudocode
        until self.ended?
            # puts "Inside Self.ended"
            self.handleNextMove
        end

        self.showResult

        #end of pseudocode
        # @my_counter=1
        # while (@my_counter<=@b.board_size*@b.board_size)
        #     unless self.ended?
        #         puts "Hi There Check Out"
        #         self.handleNextMove       
        #     end
        #     @my_counter+=1 
        # end
        # puts " "
        # puts "#{@result} wins the game!!!"
        
        # unless self.ended?
        #     self.handleNextMove  
        # else
        #    self.showResult 
        # end
    end
    
    def ended?
        self.gameIsWon?||self.gameIsDraw?
    end
    
    def gameIsWon?
        # referencePlayer
        # referencePlayerMoves
        self.rightDiagonal(@b.board,@b.board_size)||
        self.leftDiagonal(@b.board,@b.board_size)||
        self.checkRow(@b.board,@b.board_size)||
        self.checkColumn(@b.board,@b.board_size)   
    end
    
    def gameIsDraw?
        @@draw_counter+=1
        # puts "i am in"
        if(@@draw_counter==@b.board_size*@b.board_size)
            # puts "Sorry both Tied"
            if(self.leftDiagonal(@b.board,@b.board_size)==false &&
                self.rightDiagonal(@b.board,@b.board_size)==false &&
                self.checkRow(@b.board,@b.board_size)==false &&
                self.checkColumn(@b.board,@b.board_size)==false
              )
              return true
            end 
        else
            return false  
        end
       
    end
    
   
    def handleNextMove   
        # puts "Inside handle Next Move"
    #    while (@@a<=@b.board_size*@b.board_size)
            if(@@a%2!=0)
                puts " "
                puts "Now #{@p1.identifier} turn"
                puts "Place #{@p1.move_token} in board"
                puts ""
                @objx=@p1.askNextMove
                if(@objx.row>=@b.board_size||@objx.col>=@b.board_size)
                    puts " "
                    puts "Choose valid row and column"
                    self.handleNextMove
                elsif(@b.board[@objx.row][@objx.col]=="")
                    @b.board[@objx.row][@objx.col]=@p1.move_token
                    @b.printBoard
                    @@a+=1
                else
                   puts "#{@p1.identifier} please select another cell"
                   self.handleNextMove     
                end 
                
            else
                puts " "
                puts "Now #{@p2.identifier} turn"
                puts "Place #{@p2.move_token} in board"
                puts ""
                @objO=@p2.askNextMove
                if(@objO.row>=@b.board_size||@objO.col>=@b.board_size)
                    puts " "
                    puts "Choose valid row and column"
                    self.handleNextMove
                elsif(@b.board[@objO.row][@objO.col]=="")
                    @b.board[@objO.row][@objO.col]=@p2.move_token
                    @b.printBoard
                    @@a+=1
                else
                    puts "#{@p2.identifier} please select another cell"
                    self.handleNextMove     
                end 
            end
            
        # end

    end

    def leftDiagonal(board,board_size)
        xlcount=1;
        olcount=1;
        for i in 0...(board_size-1) do
            for j in 0...(board_size-1) do
                if(i==j)
                    # puts "I is #{i}"
                    # puts "J is #{j}"  
                    if(board[i][j]=="X" && board[i+1][j+1]=="X")
                        xlcount=xlcount+1;
                        if(xlcount==board_size)
                            return @result=@p1.identifier
                            # return true;
                            break;
                        end
                    elsif(board[i][j]=="O" && board[i+1][j+1]=="O")
                        olcount=olcount+1;
                        if(olcount==board_size)
                            # puts "Player O  wins the game"
                            return @result=@p2.identifier
                            # return true;
                            break;
                        end
                    else
                        # puts "No Diagonal"
                        return false 	
                    end
                end		
            end												
        end
    end

    def rightDiagonal(board,board_size)
        xrcount=1;
        orcount=1;
        for i in 0...(board_size-1) do
            for j in 0..(board_size-1) do
                if(i+j==board_size-1)
                    # puts "I is #{i}"
                    # puts "J is #{j}"  
                    if(board[i][j]=="X" && board[i+1][j-1]=="X")
                        xrcount=xrcount+1;
                        if(xrcount==board_size)
                            #  puts "Player X wins the game"
                            return @result=@p1.identifier
                            # return true;
                            break;
                        end
                    elsif(board[i][j]=="O" && board[i+1][j-1]=="O")
                        orcount=orcount+1;
                        if(orcount==board_size)
                            # puts "Player O  wins the game"
                            return @result=@p2.identifier
                            # return true;
                            break;
                        end
                    else
                        # puts "No Diagonal"
                        return false 	
                    end
                end		
            end												
        end
    end

   
    def checkRow(board,board_size)
        xcount=1;
        ycount=1;
        for i in 0..(board_size-1) do
            for j in 0...(board_size-1) do
                    # puts "I is #{i}"
                    # puts "J is #{j}"  
                    if(board[i][j]=="X" && board[i][j+1]=="X")
                        xcount=xcount+1;
                        if(xcount==board_size)
                            #  puts "Player X wins the game"
                            return @result=@p1.identifier
                            # return true;
                            break;
                        end
                    elsif(board[i][j]=="O" && board[i][j+1]=="O")
                        ycount=ycount+1;
                        if(ycount==board_size)
                            # puts "Player O  wins the game"
                            return @result=@p2.identifier
                            # return true;
                            break;
                        end
                    else
                        # puts "No Diagonal"
                        return false 	
                    end
            		
            end												
        end
    end

    def checkColumn(board,board_size)
        xcount=1;
        ycount=1;
        for i in 0..(board_size-1) do
            for j in 0...(board_size-1) do
                    # puts "I is #{i}"
                    # puts "J is #{j}"  
                    if(board[j][i]=="X" && board[j+1][i]=="X")
                        xcount=xcount+1;
                        if(xcount==board_size)
                            #  puts "Player X wins the game"
                            return @result=@p1.identifier
                            # return true;
                            break;
                        end
                    elsif(board[j][i]=="O" && board[j+1][i]=="O")
                        ycount=ycount+1;
                        if(ycount==board_size)
                            # puts "Player O  wins the game"
                            return @result=@p2.identifier
                            # return true;
                            break;
                        end
                    else
                        # puts "No Diagonal"
                        return false 	
                    end
            		
            end												
        end
    end
    

    def showResult   
        if(self.gameIsWon?)
            puts ""
            puts "Yay #{@result} wins!!!"
            # exit
        elsif(!self.gameIsDraw?)
            puts ""
            puts "Game is Tied"
        end
    end
 
end

@game=Game.new






