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
    self:whitePiecesDefault(pieces)
    self:blackPiecesDefault(pieces)
    return pieces
end

function Board:whitePiecesDefault(pieces)
    local step = self.gridSize
    local xOffset = self.xOffset
    local yOffset = self.yOffset
    local boardEnd = 8 * self.gridSize

    self:addPiece(Knight("w", step, 0, step, xOffset, yOffset))
    self:addPiece(Knight("w", boardEnd - 2 *step, 0, step, xOffset, yOffset))
    self:addPiece(Bishop("w", 2 * step, 0, step, xOffset, yOffset))
    self:addPiece(Bishop("w", boardEnd - 3 * step, 0, step, xOffset, yOffset))
    self:addPiece(Rook("w", 0, 0, step, xOffset, yOffset))
    self:addPiece(Rook("w", boardEnd - step, 0, step, xOffset, yOffset))
    self:addPiece(Queen("w", 3 * step, 0, step, xOffset, yOffset))
    self:addPiece(King("w", boardEnd - 4  * step, 0, step, xOffset, yOffset))
    for i = 0, 7 do
        self:addPiece(Pawn("w", i * step, step, step, xOffset, yOffset))
    end
end

function Board:blackPiecesDefault(pieces)
    local step = self.gridSize
    local xOffset = self.xOffset
    local yOffset = self.yOffset
    local boardEnd = 8 * self.gridSize

    self:addPiece(Knight("b", step, boardEnd - step, step, xOffset, yOffset))
    self:addPiece(Knight("b", boardEnd - 2 *step, boardEnd - step, step, xOffset, yOffset))
    self:addPiece(Bishop("b",  2 * step, boardEnd - step, step, xOffset, yOffset))
    self:addPiece(Bishop("b",  boardEnd - 3 * step, boardEnd - step, step, xOffset, yOffset))
    self:addPiece(Rook("b",  0, boardEnd - step, step, xOffset, yOffset))
    self:addPiece(Rook("b",  boardEnd - step, boardEnd - step, step, xOffset, yOffset))
    self:addPiece(Queen("b",  3 * step, boardEnd - step, step, xOffset, yOffset))
    self:addPiece(King("b",  boardEnd - 4  * step, boardEnd - step, step, xOffset, yOffset))
    for i = 0, 7 do
        self:addPiece(Pawn("b", i * step,  boardEnd - 2 * step , step, xOffset, yOffset))
    end
end

function Board:getLastMove()
    return self.lastMove
end

function Board:addPiece(piece)
    table.insert(pieces, piece)
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

function Board:getMoved()
    return self.moved
end