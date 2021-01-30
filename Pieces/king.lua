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
        if  (xo < x and x <= xf and y == yo) or
            (xf <= x and x < xo and y == yo) then
            self.castlingInProcess = false
            return true
        else          
            return false
        end
    end
    return false
end

function King:checkPossibleCasteling(pieces, board)
    if self.castlingInProcess == true then
        for key, piece in pairs(pieces) do
            if piece:getName() == "rook" and piece:getColor() == self.color then
                local x,y,castelingOK = piece:checkRookCasteling(self.castlingSide)
                if castelingOK then
                    local xo,yo = piece:getActualPos()
                    for key2, piece2 in pairs(pieces) do
                        local xp,yp = piece2:getActualPos()
                            if piece:checkTrajectory(xp, yp, x, y, xo, yo) == true and piece2:getName() ~= "king" then
                                self.castlingInProcess = false
                                return false     
                            end
                    end
                    piece:move(x,y)
                    self.castlingInProcess = false
                    return true   
                end
            end
        end
    else
    
        return true
    end
    self.castlingInProcess = false
    return false
end