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


    
function Game:validateMove(pieces, pressed,lastMove)
    if pieces[pressed]:getColor() ==  self.turn then
        if pieces[pressed]:validateMovement(lastMove) and
            self:checkMovement(pieces, pieces[pressed]:getColor(), lastMove, pressed) then
            pieces[pressed]:updatePos(lastMove)
            return true
        else
            return false
        end
    else
        return false
    end
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
        if  pieces[pressed]:checkTrajectory(movement, x, y, xf, yf, xo,yo) then -- TODO: tenes un parametro extra aca
            return false
        end
        if  pieces[i]:checkPos(color, xf, yf) and
            pressed ~= i then
            return false
        end
    end
    return true
end