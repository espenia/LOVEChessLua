Pawn = Piece:extend()


function Pawn:new(color, x, y)
    self.image = love.graphics.newImage("assets/pawn-white.png")
    self.super.new(self, color, x, y)
end

function Pawn:color()
    
end