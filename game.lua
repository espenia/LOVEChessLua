Game = Object:extend()

function Game:new()
    self.turn = "w"
    self.checkstatus = "no"
end

function Game:getTurn()
    return self.turn
end

function Game:setTurn(color)
    self.turn = color
end


    
function Game:validateMove(pieces, pressed,lastMove, board)
    if pieces[pressed]:getColor() ==  self.turn then
        king = board:getKing(self.turn)
        if pieces[pressed]:validateMovement(lastMove) and
            self:checkMovement(pieces, pieces[pressed]:getColor(), lastMove, pressed) then
            -- if -self:isKingInCheck(king, pieces) then
            --     pieces[pressed]:updatePos(lastMove)
            --     return true
            -- end
            pieces[pressed]:updatePos(lastMove)
            return true
        else
            return false
        end
    end
    return false
end

function isKingInCheck(king, pieces)
    local opponent = "w"
    if self.turn == "w" then
        opponent = "b"
    else
        opponent = "w"
    end
    for key, piece in pairs(pieces) do
        if piece:getColor() == opponent and self:canPieceCapture(piece, king, pieces) then
            return true
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
    xf,yf = movement:getEnd();
    xo,yo = movement:getStart();

    for i = 1, 32 do
        x,y = pieces[i]:getActualPos()
        if  pieces[pressed]:checkTrajectory(x, y, xf, yf, xo,yo) and
            pressed ~= i then
            return false
        end
        if  pieces[i]:checkPos(color, xf, yf) and
            pressed ~= i then
            return false
        end
    end
    return true
end

function Game:showCurrentTurn(current)
    if current == "w" then
        love.graphics.print("Current Turn: White", 670, 50)
    else
        love.graphics.print("Current Turn: Black", 670, 50)
    end
    
end

function Game:canPieceCapture(piece, otherPiece, pieces)
    local xf,yf = otherPiece:getChessPos();
    local xo,yo = piece:getChessPos();
    local movement = Move()
    if piece:validateMovement(movement) then
        if -piece:checkTrajectory(xf, yf, xf, yf, xo, yo) then --puede estar mal
            return false
        end

        for i = 1, 32 do
            local x,y = pieces[i]:getActualPos()
            if i == otherPiece then
                goto continue
            end
            if  piece:checkTrajectory(x, y, xf, yf, xo,yo) and
                piece ~= i then
                return false
            end
            if  pieces[i]:checkPos(piece:getColor(), xf, yf) and
                piece ~= i then
                return false
            end
            ::continue::
        end
        return true
    end
    return false
end