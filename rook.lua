Rook = Piece:extend()


function Rook:new(color, x, y)
    self.image = love.graphics.newImage("assets/rook-white.png")
    self.super.new(self, color, x, y)
end

function Rook:color()
    
end