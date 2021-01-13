require "piece"
require "Pieces/pawn"
require "Pieces/bishop"
require "Pieces/king"
require "Pieces/queen"
require "Pieces/rook"
require "Pieces/knight"
require "move"

Board = Object:extend()

function Board:new()
    self.xOffset = 128
    self.yOffset = self.xOffset / 4
    self.gridSize = 67
    self.pieces = self:classicStart()
    self.pressed = -1 --index of pressed piece. -1 == none pressed
    self.moved = -1 --index of last moved piece
    self.imageDark = love.graphics.newImage("assets/square-brown-dark.png")
    self.imageLight = love.graphics.newImage("assets/square-brown-light.png")
    self.imageScale = self.gridSize / self.imageDark:getWidth()
    self.lastMove = Move()
    self.newMove = false
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
        local x, y = self.pieces[self.pressed]:getChessPos()
        self.lastMove:endMove(x, y)
        self.pressed = -1
        self.newMove = true
    end
end

function Board:updateAll()
    for i = 1, #self.pieces do
        self.pieces[i]:update()
        if self.pieces[i].clicked then
            local x, y = self.pieces[i]:getChessPos()
            self.lastMove:startMove(x, y, self.pieces[i]:getName())
            self.pressed = i
            self.moved = i
            break
        end
    end
end

function Board:draw()
    self:drawBackground()
    for i = 1, #self.pieces do
        if self.pressed ~= i then
            self.pieces[i]:draw()
        end
    end
    -- draws pressed piece on top
    if self.pressed ~= -1 then
        self.pieces[self.pressed]:draw()
        love.graphics.print(self.pieces[self.pressed]:getName(), 0, 50)
    end
end

function Board:drawBackground()
    local scale, xPos, yPos = self.imageScale, 0, 0
    for i = 1, 4 do
        for j = 1,8 do
            xPos = (2 * i - 2 + j % 2) * self.gridSize + self.xOffset
            yPos = (j - 1) * self.gridSize + self.yOffset
            love.graphics.draw(self.imageDark, xPos, yPos, 0, scale, scale)
            xPos = (2 * i - 2 + (j + 1) % 2) * self.gridSize + self.xOffset
            love.graphics.draw(self.imageLight, xPos, yPos, 0, scale, scale)
        end
    end
end

function Board:classicStart()
    pieces = {}
    self:whitePieces(pieces)
    self:blackPieces(pieces)
    return pieces
end

function Board:whitePieces(pieces)
    local step = self.gridSize
    local xOffset = self.xOffset
    local yOffset = self.yOffset
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
    local xOffset = self.xOffset
    local yOffset = self.yOffset
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

function Board:getLastMove()
    return self.lastMove
end

function Board:getPieces()
    return self.pieces
end

function Board:revertLastMove()
    local x, y = self.lastMove:getStart()
    self.pieces[self.moved]:move(x, y)
    self.newMove = false
end

function Board:removeCapturedPiece()
end

function Board:isNewMove()
    return self.newMove
end