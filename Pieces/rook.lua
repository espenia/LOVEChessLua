Rook = Piece:extend()


function Rook:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    if color == "w" then
        self.image = love.graphics.newImage("assets/rook-white.png")
    else
        self.image = love.graphics.newImage("assets/rook-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset, posX, posY)
    self.name = "rook"
end

function Rook:color()
    
end

function Rook:validateMovement(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()
    if  (xo == xf and yo ~= yf and xo ~= nil) or 
        (yo == yf and xo ~= xf and yo ~= nil) then
        return true
    else
        return false
    end
end 

function Rook:checkTrajectory(x, y, xf, yf, xo, yo)

    if  (yo < y and y < yf and x == xo) or
        (xo < x and x < xf and y == yo) or
        (yf < y and y < yo and x == xo) or
        (xf < x and x < xo and y == yo) then
        return true
    else
        return false
    end
end

function Rook:checkRookCasteling(side)
    local actualXPos, actualYPos = self.actualPos:get()

    if self.color == "w" and self.firstMove == true then
        if side == 1 and actualXPos == 7 and actualYPos == 0 then
            return 4,0,true 
        elseif side == -1 and actualXPos == 0 and actualYPos == 0 then
            return 2,0,true
        else
            return 0,0,false
        end
    elseif self.color == "b" and self.firstMove == true then
        if side == 1 and actualXPos == 8 and actualYPos == 8 then
            return 4,7,true
        elseif side == -1 and actualXPos == 1 and actualYPo == 8 then
            return 2,7,true
        else
            return 0,0,false
        end
    else
        return 0,0,false
    end
end