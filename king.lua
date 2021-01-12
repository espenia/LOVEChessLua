King = Piece:extend()


function King:new(color, x, y)
    self.image = love.graphics.newImage("assets/king-white.png")
    self.super.new(self, color, x, y)
end

function King:color()
    
end