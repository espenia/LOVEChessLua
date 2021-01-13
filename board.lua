require "piece"
require "pawn"
require "bishop"
require "king"
require "queen"
require "rook"
require "knight"


Board = Object:extend()

function Board:new()
    self.offset = 120
    self.gridSize = 67
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
    self:blackPieces(pieces)
    return pieces
end

function Board:WhitePieces(pieces)
    local step = self.gridSize
    local xOffset = self.offset
    local yOffset = self.offset / 4
    local boardEnd = 8 * self.gridSize

    table.insert(pieces, Knight("w", xOffset + step, yOffset, step, xOffset, yOffset))
    table.insert(pieces, Knight("w", xOffset + boardEnd - 2 *step, yOffset, step, xOffset, yOffset))
    table.insert(pieces, Bishop("w", xOffset +  2 * step, yOffset, step, xOffset, yOffset))
    table.insert(pieces, Bishop("w", xOffset +  boardEnd - 3 * step, yOffset, step, xOffset, yOffset))
    table.insert(pieces, Rook("w", xOffset +  0, yOffset, step, xOffset, yOffset))
    table.insert(pieces, Rook("w", xOffset +  boardEnd - step, yOffset, step, xOffset, yOffset))
    table.insert(pieces, Queen("w", xOffset +  3 * step, yOffset, step, xOffset, yOffset))
    table.insert(pieces, King("w", xOffset +  boardEnd - 4  * step, yOffset, step, xOffset, yOffset))
    for i = 0, 7 do
        table.insert(pieces, Pawn("w", xOffset + i * step, step + yOffset, step, xOffset, yOffset))
    end
end

function Board:blackPieces(pieces)
    local step = self.gridSize
    local xOffset = self.offset
    local yOffset = self.offset / 4
    local boardEnd = 8 * self.gridSize

    table.insert(pieces, Knight("b", xOffset + step, boardEnd + yOffset - step, step, xOffset, yOffset))
    table.insert(pieces, Knight("b", xOffset + boardEnd - 2 *step, boardEnd + yOffset - step, step, xOffset, yOffset))
    table.insert(pieces, Bishop("b", xOffset +  2 * step, boardEnd + yOffset - step, step, xOffset, yOffset))
    table.insert(pieces, Bishop("b", xOffset +  boardEnd - 3 * step, boardEnd + yOffset - step, step, xOffset, yOffset))
    table.insert(pieces, Rook("b", xOffset +  0, boardEnd + yOffset - step, step, xOffset, yOffset))
    table.insert(pieces, Rook("b", xOffset +  boardEnd - step, boardEnd + yOffset - step, step, xOffset, yOffset))
    table.insert(pieces, Queen("b", xOffset +  3 * step, boardEnd + yOffset - step, step, xOffset, yOffset))
    table.insert(pieces, King("b", xOffset +  boardEnd - 4  * step, boardEnd + yOffset - step, step, xOffset, yOffset))
    for i = 0, 7 do
        table.insert(pieces, Pawn("b", xOffset + i * step,  boardEnd + yOffset - 2 * step , step, xOffset, yOffset))
    end
end