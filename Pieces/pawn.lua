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

function Pawn:color()
    
end

function Pawn:validateMovement(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()
    if  (xo == xf) and
        ((yf - yo == 1 and self.color == 'w') or
        (yf - yo == -1 and self.color == 'b')) then
        return true
    else
        return false
    end
end    