class Player 
    attr_accessor :playerBoard
    def initialize()
        @playerBoard = Board.new
    end
    #def beginGame()
        
    def placeShip(start, ending)
        raise ArgumentError if !start.is_a? String  
        raise ArgumentError if !ending.is_a? String 
        raise ArgumentError if start.length != 2
        raise ArgumentError if ending.length != 2
        
        isWorking = playerBoard.addShip(start, ending)
        raise ArgumentError if !isWorking

        return true

    end
    def attackPlayer(player, pos)
        raise ArgumentError if !player.is_a? Player
        raise ArgumentError if !pos.is_a? String
        raise ArgumentError if pos.length != 2
        
        return player.playerBoard.attacked(pos)
        
    end
    def won?(player)
        raise ArgumentError if !player.is_a? Player
        
        return player.playerBoard.isEnd()
         
    end
    
end
