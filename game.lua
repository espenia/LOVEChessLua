Game = Object:extend()

function Game:new()
    self.turn = "w"
    self.checkstatus = "no"
end

function Game:validateMove(pieces, pressed, lastMove)
    if  pieces[pressed]:validateMovement(lastMove) and
        self:checkEmptyBox(pieces, pieces[pressed]:getColor(), lastMove, pressed) then
        pieces[pressed]:updatePos(lastMove)
        return true
    else
        return false
    end
    -- return true
end

function Game:finished()
end

function Game:checkmated()
end

function Game:checkEmptyBox(pieces, color, movement, pressed)
    xf,yf = movement:getEnd();

    for i = 1, 32 do
        if  pieces[i]:checkPos(color, xf, yf) and
            pressed ~= i then
            return false
        end
    end
    return true
end