Queen = Piece:extend()


function Queen:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    if color == "w" then
        self.image = love.graphics.newImage("assets/queen-white.png")
    else
        self.image = love.graphics.newImage("assets/queen-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset, posX, posY)
    self.name = "queen"
end

function Queen:color()
    
end

function Queen:validateMovement(movement)
    if  Rook:validateMovement(movement) or
        Bishop:validateMovement(movement)then
        return true
    else
        return false
    end
end  

function Queen:checkTrajectory( x, y, xf, yf, xo,yo)
    if  Rook:checkTrajectory( x, y, xf, yf, xo,yo) or
        Bishop:checkTrajectory( x, y, xf, yf, xo,yo) then
            return true
    else
        return false    
    end
end