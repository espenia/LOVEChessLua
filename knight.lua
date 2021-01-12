Knight = Piece:extend()


function Knight:new(color, x, y)
    self.image = love.graphics.newImage("assets/knight-white.png")
    self.super.new(self, color, x, y)
end

function Knight:color()
    
end