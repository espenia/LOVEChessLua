Game = Object:extend()

function Game:new()
    self.turn = "w"
    self.checkstatus = "no"
end

function Game:validateMove(move, pieces)
    --completar
    return true
end

function Game:finished()
end

function Game:checkmated()
end