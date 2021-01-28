Pawn = Piece:extend()


function Pawn:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    if color == "w" then
        self.image = love.graphics.newImage("assets/pawn-white.png")
    else
        self.image = love.graphics.newImage("assets/pawn-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset, posX, posY)
    self.name = "pawn"
end


function Pawn:validateMovement(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()

    if  not self.firstMove and
        (xo == xf) and
        ((yf - yo == 1 and self.color == 'w') or
        (yf - yo == -1 and self.color == 'b')) then
        return true
    elseif  self.firstMove and
            (xo == xf) and
            (((yf - yo == 1 or yf - yo == 2) and self.color == 'w') or
            ((yf - yo == -1 or yf - yo == -2) and self.color == 'b')) then
        return true
    else    
        return false
    end
end   

function Pawn:canCapture(movement)
    xo,yo = movement:getStart()
    xf,yf = movement:getEnd()

    if  (xf - xo == 1 or xf - xo == -1) and
        ((yf - yo == 1 and self.color == 'w') or
        (yf - yo == -1 and self.color == 'b')) then
        return true
    else
        return false
    end
end

function Pawn:checkTrajectory(x, y, xf, yf, xo, yo)
    return false;
end


function Piece:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    local imgGridRatio = 0.9 -- img has 90% width of grid width
    self.gridSize = gridSize
    self.heightScale = gridSize * imgGridRatio / self.image:getHeight()
    self.widthScale = self.heightScale -- squared
    self.width = self.image:getWidth() * self.widthScale
    self.height = self.image:getHeight() * self.heightScale
    self.xOffset = xOffset
    self.yOffset = yOffset
    self.x = x + self.xOffset + (self.gridSize - self.width) / 2
    self.y = y + self.yOffset + (self.gridSize - self.height) / 2
    self.speed = 500
    self.clicked = false
    self.color = color
    self.drawOffset = 5
    self.actualPos = Square()
    self.actualPos:set(posX, posY)
    self.captured = false
    self.firstMove = true
    self.castlingInProcess = false
end


function Pawn:promotion(pieces, i)
    if i == 4 then
        return
    end
    local w,z = self.actualPos:get()
    local newX = w * self.gridSize
    local newY = z * self.gridSize
    if i == 0 then
        table.insert(pieces, Bishop(self.color, newX, newY, self.gridSize, self.xOffset, self.yOffset, w, z))
    elseif i == 1 then
        table.insert(pieces, Knight(self.color, newX, newY, self.gridSize, self.xOffset, self.yOffset, w, z))
    elseif i == 2 then
        table.insert(pieces, Rook(self.color, newX, newY, self.gridSize, self.xOffset, self.yOffset, w, z))
    elseif i == 3 then
        table.insert(pieces, Queen(self.color, newX, newY, self.gridSize, self.xOffset, self.yOffset, w, z))
    end
end