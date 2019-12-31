class Board
    attr_accessor :x_axis, :y_axis, :ship_limits, :ship_sizes, :ship_pos, :fullBoard
    def initialize
        @x_axis = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        @y_axis = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        @ship_sizes = [3, 4, 5]
        @ship_limits = [4, 2, 1]
        @ship_pos = []
        @fullBoard = Array.new(10){Array.new(10, "#")}
    end
    
    def fillBoardWithShips()
        for i in @ship_pos do
            pos=i.split
            pos=returnPositions(pos[0], pos[1])
            for j in pos do
                @fullBoard[j[1].to_i][y_axis.index(j[0])]="o"
            end
        end
        
    end
    def returnBoardAsString()
        retBoard = "X" 
        for i in @x_axis do
            retBoard+=i.to_s
        end

        for i in 0 ... @y_axis.count do
            retBoard+="\n#{@y_axis[i]}"
            for j in @x_axis do
                retBoard+=@fullBoard[j][i]
            end
        end
        return retBoard
    end
    def attacked(pos)
        raise ArgumentError if pos.to_s.length != 2 || !pos.to_s[0].match?(/[A-Z]/) || !pos.to_s[1].match?(/[0-9]/)
        raise ArgumentError if !@y_axis.include?(pos[0]) || !@x_axis.include?(pos[1].to_i)
        x=pos[1].to_i
        y=@y_axis.index(pos[0])
        if @fullBoard[x][y]=="o"
            @fullBoard[x][y]="X"
            return true
        else
            @fullBoard[x][y]="x"
            return false
        end
    end
    def isEnd()
        for i in 0...y_axis.count do
            for j in 0...x_axis.count do
                if @fullBoard[j][i]=="o"
                    return false
                end
            end
        end
         
        return true
    end
    def returnPositions(start, ending)
        raise ArgumentError if start[0] != ending[0] && start[1] != ending[1]
        raise ArgumentError if !start[0].match?(/[A-Z]/) || !ending[0].match?(/[A-Z]/)
        raise ArgumentError if !start[1].match?(/[0-9]/) || !ending[1].match?(/[0-9]/)
        if start[0] == ending[0]    #pozycje poziome
            tmpArr = []
            
            for i in start[1].to_i .. ending[1].to_i do
                tmpArr << start[0] + x_axis[i].to_s
            end
            
            return tmpArr
        else        #pozycje pionowe
            tmpArr = []
            for i in y_axis.index(start[0]) .. y_axis.index(ending[0])
                tmpArr << y_axis[i] + start[1]  

            end
            return tmpArr
        end

        
    end

    def getSize(start, ending)
        if start[0] == ending[0]
            return (ending[1].to_i - start[1].to_i).abs + 1
        
        else
            raise ArgumentError if start[1] != ending[1]
            return (y_axis.index(ending[0]) - y_axis.index(start[0])).abs + 1
        end
    end
    def isCrossing(start, ending)
        for i in @ship_pos do
            tmpArr=returnPositions(start, ending)
            lockedPositions=i.split
            lockedPositions=returnPositions(lockedPositions[0], lockedPositions[1])
            for j in lockedPositions do
                if tmpArr.include?(j) 
                    return true
                end

            end

        end

        return false

    end
    def addShip(start, ending)
            
            
            raise ArgumentError if !start.is_a? String || !start[0].match?(/[A-Z]/) || !ending[0].match?(/[A-Z]/)
            raise ArgumentError if !start.is_a? String || !start[1].match?(/[0-9]/) || !ending[1].match?(/[0-9]/) 
      
            
            raise ArgumentError if !@y_axis.include?(start[0]) || !@x_axis.include?(start[1].to_i)
            raise ArgumentError if !@y_axis.include?(ending[0]) || !@x_axis.include?(ending[1].to_i)
            raise ArgumentError if !@ship_sizes.include?(getSize(start, ending))
            raise ArgumentError if @ship_limits[@ship_sizes.index(getSize(start, ending))] <= 0
            
            if !isCrossing(start, ending)
                @ship_pos<<start + " " + ending
                @ship_limits[@ship_sizes.index(getSize(start, ending))]-=1
                fillBoardWithShips()
                return true
            else 
                return false
            end
    
    end
     
end    