Queen = Piece:extend()


function Queen:new(color, x, y)
    self.image = love.graphics.newImage("assets/queen-white.png")
    self.super.new(self, color, x, y)
end

function Queen:color()
    
end