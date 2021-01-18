Queen = Piece:extend()


function Queen:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    if color == "w" then
        self.image = love.graphics.newImage("assets/queen-white.png")
    else
        self.image = love.graphics.newImage("assets/queen-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset, posX, posY)
    self.name = "queen"
end

function Queen:color()
    
end

function Queen:validateMovement(movement)
    if  Rook:validateMovement(movement) or
        Bishop:validateMovement(movement)then
        return true
    else
        return false
    end
end  