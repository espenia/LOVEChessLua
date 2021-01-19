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

function Bishop:color()
    
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

function Bishop:checkTrajectory(x, y, xf, yf, xo,yo)
    deltaX = xf - xo
    deltaY = yf - yo

    if  ((xo < x and x < xf and 
        yo < y and y < yf) or
        (xf < x and x < xo and
        yf < y and y < yo) or
        (xo < x and x < xf and 
        yf < y and y < yo) or
        (xf < x and x < xo and 
        yo < y and y < yf)) and
        (x - y == deltaX and x - y == deltaY) then
        -- (y - yo == deltaY or y - yo == - deltaY)) then
        return true
    else
        return false
    end
end