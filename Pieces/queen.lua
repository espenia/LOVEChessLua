Queen = Piece:extend()


function Queen:new(color, x, y, gridSize, xOffset, yOffset)
    if color == "w" then
        self.image = love.graphics.newImage("assets/queen-white.png")
    else
        self.image = love.graphics.newImage("assets/queen-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset)
    self.name = "queen"
end

function Queen:color()
    
end