Bishop = Piece:extend()


function Bishop:new(color, x, y, gridSize, xOffset, yOffset)
    if color == "w" then
        self.image = love.graphics.newImage("assets/bishop-white.png")
    else
        self.image = love.graphics.newImage("assets/bishop-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset)
    self.name = "bishop"
end


function Bishop:validateMovement(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()
    delta = xf-xo
    if  (yo + delta == yf) or 
        (yo - delta == yf) then
        return true
    else
        return false
    end
end  