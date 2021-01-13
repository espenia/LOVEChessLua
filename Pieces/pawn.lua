Pawn = Piece:extend()


function Pawn:new(color, x, y, gridSize, xOffset, yOffset)
    if color == "w" then
        self.image = love.graphics.newImage("assets/pawn-white.png")
    else
        self.image = love.graphics.newImage("assets/pawn-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset)
end

function Pawn:color()
    
end