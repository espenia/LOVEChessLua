Rook = Piece:extend()


function Rook:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    if color == "w" then
        self.image = love.graphics.newImage("assets/rook-white.png")
    else
        self.image = love.graphics.newImage("assets/rook-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset, posX, posY)
    self.name = "rook"
end

function Rook:color()
    
end

function Rook:validateMovement(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()
    if  (xo == xf) or 
        (yo == yf) then
        return true
    else
        return false
    end
end 

function Rook:checkTrajectory(x, y, xf, yf, xo, yo)

    if  (yo < y and y < yf and x == xo) or
        (xo < x and x < xf and y == yo) or
        (yf < y and y < yo and x == xo) or
        (xf < x and x < xo and y == yo) then
        return true
    else
        return false
    end
end