Knight = Piece:extend()


function Knight:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    if color == "w" then
        self.image = love.graphics.newImage("assets/knight-white.png")
    else
        self.image = love.graphics.newImage("assets/knight-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset, posX, posY)
    self.name = "knight"
end

function Knight:color()
    
end

function Knight:validateMovement(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()
    if  ((xo == xf + 1 or xo == xf -1) and
        (yo == yf + 2 or yo == yf -2)) or 
        ((xo == xf + 2 or xo == xf - 2) and
        (yo == yf + 1 or yo == yf -1))   then
        return true
    else
        return false
    end
end  