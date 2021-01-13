Move = Object:extend()

require "square"

function Move:new()
    self.startSquare = Square()
    self.endSquare = Square()
    self.piece = ""
end

function Move:startMove(x, y, pieceName)
    self.startSquare:set(x, y)
    self.piece = pieceName
end

function Move:endMove(x, y)
    self.endSquare:set(x, y)
end

function Move:getStart()
    return self.startSquare:get()
end