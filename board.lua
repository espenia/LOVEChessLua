require "piece"
require "pawn"
require "bishop"
require "king"
require "queen"
require "rook"
require "knight"


Board = Object:extend()

function Board:new()
    self.gridSize = 100
    self.pieces = self:Pieces()
end

function Board:update(dt)
    for i = 1, #self.pieces do
        self.pieces[i]:update()
    end
end

function Board:draw()
    for i = 1, #self.pieces do
        self.pieces[i]:draw()
    end
end

function Board:Pieces()
    pieces = {}
    self:WhitePieces(pieces)
    return pieces
end

function Board:WhitePieces(pieces)
    local step = self.gridSize
    local boardEnd = 8 * self.gridSize
    table.insert(pieces, Knight("w", step, 20))
    table.insert(pieces, Knight("w", boardEnd - 2 *step, 20))
    table.insert(pieces, Bishop("w", 2 * step, 20))
    table.insert(pieces, Bishop("w", boardEnd - 3 * step, 20))
    table.insert(pieces, Rook("w", 0, 20))
    table.insert(pieces, Rook("w", boardEnd - step, 20))
    table.insert(pieces, Queen("w", 3 * step, 20))
    table.insert(pieces, King("w", boardEnd - 4  * step, 20))
end