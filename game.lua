Game = Object:extend()

function Game:new()
    self.turn = "w"
end

function Game:getTurn()
    return self.turn
end

function Game:setTurn(color)
    self.turn = color
end
    
function Game:validateMove(pieces, pressed, lastMove, board)
    if pieces[pressed]:getColor() ==  self.turn then
        local king = board:getKing(self.turn)

        if  self:checkMovement(pieces, pieces[pressed]:getColor(), lastMove, pressed) then
            if not self:isKingInCheck(king, pieces) then
                local capturedPiece = self:checkPieceToBeCaptured(pieces, lastMove, pressed)
                if pieces[pressed]:checkPossibleCasteling(pieces, board, self:getArraySize(pieces)) == false  then
                    return false
                end
                pieces[pressed]:updatePos(lastMove)
                if self:isKingInCheck(king, pieces) then
                    self:resetCapturedFlags()
                    return false
                else
                    if capturedPiece then
                        board:removeCapturedPiece(capturedPiece)
                        self:resetCapturedFlags()
                    end
                    
                    return true
                end
                
            else
                local capturedPiece = self:checkPieceToBeCaptured(pieces, lastMove, pressed)
                pieces[pressed]:updatePos(lastMove)
                if capturedPiece then
                    board:removeCapturedPiece(capturedPiece)
                    self:resetCapturedFlags()
                end
                --pieces = board:getPieces()
                if self:isKingInCheck(king, pieces) then
                    if capturedPiece then
                        board:addPiece(capturedPiece)
                    end
                    return false
                end
                return true
                
            end
        end
    end
    return false
end


function Game:nextTurn()
    if game:getTurn() == "w" then
        game:setTurn("b")
    else
        game:setTurn("w")
    end
end

function Game:finished()
end

function Game:checkmated()
end

function Game:checkMovement(pieces, color, movement, pressed)
    local xf,yf = movement:getEnd();
    local xo,yo = movement:getStart();

    if (pieces[pressed]:validateMovement(movement)) then
        for i = 1, self:getArraySize(pieces)  do
            if (pieces[i]) then
                local x,y = pieces[i]:getActualPos()
                if  pieces[pressed]:checkTrajectory(x, y, xf, yf, xo, yo) and
                    pressed ~= i then
                    return false
                end
                if  pieces[i]:checkPos(color, xf, yf) and
                    pressed ~= i then
                    return false
                end
                
                if  pieces[i]:checkCoordinates(xf, yf) and
                    not pieces[pressed]:canCapture(movement) and
                    pressed ~= i then
                    return false
                end
            end
        end
    else
        for i = 1, self:getArraySize(pieces) do
            if  pieces[i] and
                pieces[i]:checkCoordinates(xf, yf) and 
                pieces[pressed]:canCapture(movement) and 
                pressed ~= i then
                return true
            elseif not pieces[i] then
                return false
            end
        end
        return false
    end
    return true
end


function Game:isKingInCheck(king, pieces)
    local opponent = "w"
    if self.turn == "w" then
        opponent = "b"
    else
        opponent = "w"
    end
    for i = 1, self:getArraySize(pieces) do
        if pieces[i]:getColor() == opponent and self:canPieceCapture(i, king, pieces) then
            return true
        end
    end
    -- for key, piece in pairs(pieces) do
    --     if piece:getColor() == opponent and self:canPieceCapture(piece, king, pieces) then
    --         return true
    --     end
    -- end
    return false
end



function Game:checkPieceToBeCaptured(pieces, movement, pressed)
    local xf,yf = movement:getEnd();
    for i = 1, self:getArraySize(pieces) do
        if  pieces[i] and
            pressed ~= i and
            pieces[i]:getName() ~= "king" and
            pieces[i]:checkCoordinates(xf, yf) then
            pieces[i]:toBeCaptured(true)
            return pieces[i]
        end
    end
    return false
end


function Game:canPieceCapture(pressed, otherPiece, pieces)
    local movement = Move()
    local xo,yo = pieces[pressed]:getActualPos()
    local xf,yf = otherPiece:getActualPos()
    movement:startMove(xo, yo, pieces[pressed]:getName())
    movement:endMove(xf, yf)
    if self:checkMovement(pieces, pieces[pressed]:getColor(), movement, pressed) then
        return true
    end
    return false

end

function Game:resetCapturedFlags()
    for i = 1, self:getArraySize(pieces) do
        if  pieces[i] then
            pieces[i]:toBeCaptured(false)
        end
    end
end

function Game:showCurrentTurn(current, x, y)
    if current == "w" then
        love.graphics.print("Turn: White", x, y)
    else
        love.graphics.print("Turn: Black", x, y)
    end
end

function Game:getArraySize(array)
    i = 0
    for key, value in pairs(array) do
        i = i + 1
    end
    return i
end


function Game:isPawnPromotion(pieces , color)
    for key, piece in pairs(pieces) do
        local x,y = piece:getActualPos()
        if piece:getColor() == "w" and piece:getColor() == color 
        and y == 7 and piece:getName() == "pawn" then
            return piece
        elseif piece:getColor() == "b" and piece:getColor() == color
        and y == 0 and piece:getName() == "pawn" then
            return piece
        end
    end
    return false
end