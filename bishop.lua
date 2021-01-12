Bishop = Piece:extend()


function Bishop:new(color, x, y)
    self.image = love.graphics.newImage("assets/bishop-white.png")
    self.super.new(self, color, x, y)
end

function Bishop:color()
    
end