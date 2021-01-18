Game = Object:extend()

function Game:new()
    self.turn = "w"
    self.checkstatus = "no"
end

function Game:setTurn(color)
    self.turn = color
end

function Game:getTurn()
    if self.turn ~= "w" and self.turn ~="b" then
        self.turn = "w"
    end
    return self.turn
end

function Game:validateMove(pieces, pressed,lastMove)
    if pieces[pressed]:getColor() ==  self.turn then  -- siempre devuelve false por alguna razon
        if pieces[pressed]:validateMovement(lastMove) then
            return true
        else
            return false
        end
    end
    return false
end

function Game:finished()
end

function Game:checkmated()
end