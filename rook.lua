Rook = Piece:extend()


function Rook:new(color, x, y, gridSize, xOffset, yOffset)
    if color == "w" then
        self.image = love.graphics.newImage("assets/rook-white.png")
    else
        self.image = love.graphics.newImage("assets/rook-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset)
end

function Rook:color()
    
end