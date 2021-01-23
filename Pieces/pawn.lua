Pawn = Piece:extend()


function Pawn:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    if color == "w" then
        self.image = love.graphics.newImage("assets/pawn-white.png")
    else
        self.image = love.graphics.newImage("assets/pawn-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset, posX, posY)
    self.name = "pawn"
end


function Pawn:validateMovement(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()

    if  not self.firstMove and
        (xo == xf) and
        ((yf - yo == 1 and self.color == 'w') or
        (yf - yo == -1 and self.color == 'b')) then
        return true
    elseif  self.firstMove and
            (xo == xf) and
            (((yf - yo == 1 or yf - yo == 2) and self.color == 'w') or
            ((yf - yo == -1 or yf - yo == -2) and self.color == 'b')) then
        return true
    else    
        return false
    end
end   

function Pawn:canCapture(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()

    if  (xf - xo == 1 or xf - xo == -1) and
        ((yf - yo == 1 and self.color == 'w') or
        (yf - yo == -1 and self.color == 'b')) then
        return true
    else
        return false
    end
end

function Pawn:checkTrajectory(x, y, xf, yf, xo, yo)
    return false;
end
