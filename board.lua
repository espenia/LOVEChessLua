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
    self.pressed = -1 --index of pressed piece. -1 == none pressed
end

function Board:update(dt)
    if self.pressed ~= -1 then
        self:updatePressed()
    end
    if self.pressed == -1 then
        self:updateAll()
    end
end

function Board:updatePressed()
    self.pieces[self.pressed]:update()
    if self.pieces[self.pressed].clicked == false then
        self.pressed = -1
    end
end

function Board:updateAll()
    for i = 1, #self.pieces do
        self.pieces[i]:update()
        if self.pieces[i].clicked then
            self.pressed = i
            break
        end
    end
end

function Board:draw()
    for i = 1, #self.pieces do
        if self.pressed ~= i then
            self.pieces[i]:draw()
        end
    end
    -- draws pressed piece on top
    if self.pressed ~= -1 then
        self.pieces[self.pressed]:draw()
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
    for i = 0, 7 do
        table.insert(pieces, Pawn("w", i * step, 120))
    end
end