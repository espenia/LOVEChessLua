Pawn = Piece:extend()


function Pawn:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    if color == "w" then
        self.image = love.graphics.newImage("assets/pawn-white.png")
    else
        self.image = love.graphics.newImage("assets/pawn-black.png")
    end
    self.super.new(self, color, x, y, gridSize, xOffset, yOffset, posX, posY)
    self.name = "pawn"
    self.canBeEnPassant = false
    self.enPassant = false
end


function Pawn:validateMovement(movement)
    local xo,yo = movement:getStart()
    local xf,yf = movement:getEnd()
    self:setCanBeEnPassant(false)

    if  not self.firstMove and
        (xo == xf) and
        ((yf - yo == 1 and self.color == 'w') or
        (yf - yo == -1 and self.color == 'b')) then
        return true
    elseif  self.firstMove and
            (xo == xf) and
            (((yf - yo == 2) and self.color == 'w') or
            ((yf - yo == -2) and self.color == 'b')) then
        self.canBeEnPassant = true
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

function Pawn:canCapture(movement, pieceToCapture)
    local xo,yo = movement:getStart()
    local xf,yf = movement:getEnd()

    local y,z = pieceToCapture:getActualPos()

    print(pieceToCapture:getName())
    print(xo, yo)
    print(xf, yf)
    print(y,z)
    print(self.color)

    if  pieceToCapture:getName() == 'pawn' and
        pieceToCapture:getCanBeEnPassant() and
        (z == yo) and
        ((y - xo == 1 and self.color ~= pieceToCapture:getColor()) or
        (y - xo == -1 and self.color ~= pieceToCapture:getColor())) and
        (xf - xo == 1 or xf - xo == -1) and
        ((yf - yo == 1 and self.color == 'w') or
        (yf - yo == -1 and self.color == 'b')) then
            pieceToCapture:setEnPassant(true)
            --pieceToCapture:setCanBeEnPassant(false)
        return true
    end

    if  pieceToCapture:checkCoordinates(xf, yf) and
        (xf - xo == 1 or xf - xo == -1) and
        ((yf - yo == 1 and self.color == 'w') or
        (yf - yo == -1 and self.color == 'b')) then
        return true
    else
        return false
    end
end

function Pawn:checkTrajectory(x, y, xf, yf, xo, yo)
    return false
end

function Pawn:getCanBeEnPassant()
    return self.canBeEnPassant
end

function Piece:getEnPassant()
    return self.enPassant
end

function Piece:setEnPassant(boolean)
    self.enPassant = boolean
end

function Piece:setCanBeEnPassant(boolean)
    self.canBeEnPassant = boolean
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

function Pawn:promotion(name)
    local w,z = self.actualPos:get()
    local newX, newY = w * self.gridSize, z * self.gridSize
    local newPiece
    if name == "bishop" then
        newPiece = Bishop(self.color, newX, newY, self.gridSize, self.xOffset, self.yOffset, w, z)
    elseif name == "knight" then
        newPiece = Knight(self.color, newX, newY, self.gridSize, self.xOffset, self.yOffset, w, z)
    elseif name == "rook" then
        newPiece = Rook(self.color, newX, newY, self.gridSize, self.xOffset, self.yOffset, w, z)
    elseif name == "queen" then
        newPiece = Queen(self.color, newX, newY, self.gridSize, self.xOffset, self.yOffset, w, z)
    end
    return newPiece
end
