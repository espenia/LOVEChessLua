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

    if  pieceToCapture:getName() == 'pawn' and
        pieceToCapture:getCanBeEnPassant() and
        (z == yo) and
        ((y - xo == 1 and self.color ~= pieceToCapture:getColor()) or
        (y - xo == -1 and self.color ~= pieceToCapture:getColor())) and
        (xf - xo == 1 or xf - xo == -1) and
        ((yf - yo == 1 and self.color == 'w') or
        (yf - yo == -1 and self.color == 'b')) then
            pieceToCapture:setEnPassant(true)
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

-- function Pawn:enPassant(pieceToCapture)
--     print("Color to capture:")
--     print(pieceToCapture:getColor())
--     print("My color:")
--     print(self:getColor())
--     xo,yo = self:getActualPos()
--     print(xo)
--     print(yo)
--     xf,yf = pieceToCapture:getActualPos()
--     print(xf)

--     print(yf)
--     if  pieceToCapture.canBeEnPassant and
--         yf == y0 and
--         ((xf - xo == 1) or
--         (xf - xo == -1)) and
--         pieceToCapture:getColor() ~= self:getColor() then
--             print("en passant")
--         return true
--     else
--         -- print("no en passant")
--         return false
--     end
-- end