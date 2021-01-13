Bishop = Piece:extend()


function Bishop:new(color, x, y, gridSize, xOffset, yOffset)
    if color == "w" then
        self.image = love.graphics.newImage("assets/bishop-white.png")
    else
        self.image = love.graphics.newImage("assets/bishop-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset)
    self.name = "bishop"
end

function Bishop:color()
    
end