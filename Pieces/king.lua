King = Piece:extend()


function King:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    if color == "w" then
        self.image = love.graphics.newImage("assets/king-white.png")
    else
        self.image = love.graphics.newImage("assets/king-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset, posX, posY)
    self.name = "king"
    self.castlingSide = 0
end


function King:color()
    
end

function King:validateMovement(movement)
    local xo,yo = movement:getStart()
    local xf,yf = movement:getEnd()
    local deltaX = xo - xf
    local deltaY = yo - yf
    if  (deltaX == 1 and deltaY == 0) or
        (deltaX == - 1 and deltaY == 0) or 
        (deltaX == 0 and deltaY == 1) or
        (deltaX == 0 and deltaY == - 1) or
        (deltaX == 1 and deltaY == 1) or
        (deltaX == 1 and deltaY == -1) or
        (deltaX == -1 and deltaY == 1) or
        (deltaX == -1 and deltaY == -1) then
        return true
    elseif ((deltaX == 2 or deltaX == -2) and deltaY == 0) and
            self.firstMove == true then
            self.castlingInProcess = true
            if deltaX == -2 then
                self.castlingSide = 1
            else
                self.castlingSide = -1
            end
            return true       
    else 
        return false
    end
end  

function King:checkTrajectory( x, y, xf, yf, xo,yo)
    if self.castlingInProcess == true then
        if  (xo < x and x < xf and y == yo) or
            (xf < x and x < xo and y == yo) then
            return true
        else
            return false
        end
    end
end

function King:checkPossibleCasteling(pieces, board, size)
    
    if self.castlingInProcess == true then
        for i = 1, size do
            if pieces[i]:getName() == "rook" and pieces[i]:getColor() == self.color then
                local x,y,castelingOK = pieces[i]:checkRookCasteling(self.castlingSide)
                if castelingOK then
                    local xo,yo = pieces[i]:getActualPos()
                    for j = 1, size do
                        local xp,yp = pieces[j]:getActualPos()
                            if pieces[i]:checkTrajectory(xp, yp, x, y, xo, yo) == true and pieces[j]:getName() ~= "king" then
                                self.castlingInProcess = false
                                return false     
                            end
                    end
                    pieces[i]:move(x,y)
                    self.castlingInProcess = false
                    return true   
                end    
            end
        end
    end
    self.castlingInProcess = false
    return true
end