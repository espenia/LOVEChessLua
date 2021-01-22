Bishop = Piece:extend()


function Bishop:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    if color == "w" then
        self.image = love.graphics.newImage("assets/bishop-white.png")
    else
        self.image = love.graphics.newImage("assets/bishop-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset, posX, posY)
    self.name = "bishop"
end


function Bishop:validateMovement(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()
    delta = xf-xo
    if  delta ~= 0 and
        ((yo + delta == yf) or 
        (yo - delta == yf)) then
        return true
    else
        return false
    end
end 

function Bishop:checkTrajectory(x, y, xf, yf, xo,yo)
    deltaX = xf - xo 
    deltaY = yf - yo
    if xf < xo then
        deltaX = xo-xf
    end
    deltaX = deltaX - 1
    for i = 1, deltaX do
        if  (x + i == xf and y + i == yf and x < xf and y < yf and xo < x and yo < y) or
            (x - i == xf and y + i == yf and x > xf and y < yf and x < xo and yo < y) or
            (x + i == xf and y - i == yf and x < xf and y > yf and xo < x and yo > y) or
            (x - i == xf and y - i == yf and x > xf and y > yf and x < xo and yo > y) then
            return true
        end
    end    
    return false
    
end