Queen = Piece:extend()


function Queen:new()
    self.image = love.graphics.newImage("assets/queen-white.png")
    self.super.new(self)
end

function Queen:color()
    
end