Bishop = Piece:extend()


function Knight:new()
    self.image = love.graphics.newImage("assets/knight-white.png")
    self.super.new(self)
end

function Knight:color()
    
end