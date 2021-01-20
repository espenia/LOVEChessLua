Game = Object:extend()

function Game:new()
    self.turn = "w"
    self.checkstatus = "no"
end

function Game:validateMove(pieces, pressed, lastMove)
    if  pieces[pressed]:validateMovement(lastMove) and
        self:checkMovement(pieces, pieces[pressed]:getColor(), lastMove, pressed) then
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