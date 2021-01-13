King = Piece:extend()


function King:new(color, x, y, gridSize, xOffset, yOffset)
    if color == "w" then
        self.image = love.graphics.newImage("assets/king-white.png")
    else
        self.image = love.graphics.newImage("assets/king-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset)
end

function King:color()
    
end