Rook = Piece:extend()


function Rook:new()
    self.image = love.graphics.newImage("assets/rook-white.png")
    self.super.new(self)
end

function Rook:color()
    
end