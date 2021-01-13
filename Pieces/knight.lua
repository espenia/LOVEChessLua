Knight = Piece:extend()


function Knight:new(color, x, y, gridSize, xOffset, yOffset)
    if color == "w" then
        self.image = love.graphics.newImage("assets/knight-white.png")
    else
        self.image = love.graphics.newImage("assets/knight-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset)
    self.name = "knight"
end

function Knight:color()
    
end