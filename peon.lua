Peon = Piece:extend()


function Peon:new()
    self.image = love.graphics.newImage("assets/pawn-white.png")
    self.super.new(self)
end

function Peon:color()
    
end