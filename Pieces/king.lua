King = Piece:extend()


function King:new(color, x, y, gridSize, xOffset, yOffset)
    if color == "w" then
        self.image = love.graphics.newImage("assets/king-white.png")
    else
        self.image = love.graphics.newImage("assets/king-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset)
    self.name = "king"
end


function King:color()
    
end

function King:validateMovement(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()
    deltaX = xo - xf
    deltaY = yo - yf
    if  (deltaX == 1 and deltaY == 0) or
        (deltaX == - 1 and deltaY == 0) or 
        (deltaX == 0 and deltaY == 1) or
        (deltaX == 0 and deltaY == - 1) or
        (deltaX == 1 and deltaY == 1) or
        (deltaX == 1 and deltaY == -1) or
        (deltaX == -1 and deltaY == 1) or
        (deltaX == -1 and deltaY == -1) then
        return true
    else
        return false
    end
end  