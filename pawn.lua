Pawn = Piece:extend()


function Pawn:new()
    self.image = love.graphics.newImage("assets/pawn-white.png")
    self.super.new(self)
end

function Pawn:color()
    
end