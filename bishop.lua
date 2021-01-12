Bishop = Piece:extend()


function Bishop:new()
    self.image = love.graphics.newImage("assets/bishop-white.png")
    self.super.new(self)
end

function Bishop:color()
    
end