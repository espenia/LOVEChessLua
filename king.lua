King = Piece:extend()


function King:new()
    self.image = love.graphics.newImage("assets/king-white.png")
    self.super.new(self)
end

function King:color()
    
end