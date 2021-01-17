Rook = Piece:extend()


function Rook:new(color, x, y, gridSize, xOffset, yOffset)
    if color == "w" then
        self.image = love.graphics.newImage("assets/rook-white.png")
    else
        self.image = love.graphics.newImage("assets/rook-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset)
    self.name = "rook"
end

function Rook:color()
    
end

function Rook:validateMovement(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()
    if  (xo == xf) or 
        (yo == yf) then
        return true
    else
        return false
    end
end  