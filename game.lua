Game = Object:extend()

function Game:new()
    self.turn = "w"
    self.checkstatus = "no"
end

function Game:validateMove(pieces, pressed,lastMove)
    if pieces[pressed]:validateMovement(lastMove) then
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