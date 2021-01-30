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
    self.gridSize = 67
    self.tiles = 8 --board squares
    self.xOffset = (love.graphics.getWidth() - self.gridSize * self.tiles) / 2
    self.yOffset = (love.graphics.getHeight() - self.gridSize * self.tiles) / 2
    self.pieces = {}
    self:classicStart()
    self.pressed = -1 --index of pressed piece. -1 == none pressed
    self.moved = -1 --index of last moved piece
    self.imageDark = love.graphics.newImage("assets/square-brown-dark.png")
    self.imageLight = love.graphics.newImage("assets/square-brown-light.png")
    self.imageScale = self.gridSize / self.imageDark:getWidth()
    self.lastMove = Move()
    self.newMove = false
    self.promotionPieces = {}
    self.pressedPromotion = -1
    self.newPromotion = false
end

function Board:update(dt, turn)
    if self.pressed ~= -1 then
        self:updatePressed()
    end
    if self.pressed == -1 then
        self:updateAll()
    end
    self:updatePromotionSelection(turn)
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

function Board:updateAllPromotion()
    for key, piece in pairs(self.promotionPieces) do
        piece:update()
        if piece.clicked then
            self.pressedPromotion = key
            break
        end
    end
end

function Board:isNewPromotion()
    return self.newPromotion
end

function Board:isNotWaitingForPromotion()
    return self.promotionPieces == nil or next(self.promotionPieces) == nil
end

function Board:updatePromotionSelection(turn)
    self.newPromotion = false
    self:updateAllPromotion()
    local promotionSelected = self.promotionPieces[self.pressedPromotion]
    if promotionSelected ~= nil then
        for key, piece in pairs(self.pieces) do
            local x, y = piece:getActualPos()
            if piece:getName() == "pawn" and (y == self.tiles - 1 or y == 0) then
                self.pieces[key] = self:promotePawn(promotionSelected, piece)
            end
        end
    end
end

function Board:promotePawn(promotionSelected, pawn)
    local newPiece = pawn:promotion(promotionSelected:getName())
    self.newPromotion = true
    self.promotionPieces = {}
    self.pressedPromotion = -1
    return newPiece
end

function Board:spawnPromotionPieces(pawn)
    local i,j = pawn:getActualPos()
    local step = self.gridSize
    local xOffset = self.xOffset
    local yOffset = self.yOffset
    local boardEnd = self.tiles * self.gridSize
    local knight, bishop, rook, queen
    --self.promotionPieces = {}
    if pawn:getColor() == "w" then
        knight = Knight(pawn:getColor(), boardEnd, boardEnd - step, step, xOffset, yOffset, 8, j)
        bishop = Bishop(pawn:getColor(),  boardEnd , boardEnd - 2 * step, step, xOffset, yOffset, 8, j + 1)
        rook = Rook(pawn:getColor(),  boardEnd , boardEnd - 3 * step, step, xOffset, yOffset, 8, j + 3)
        queen = Queen(pawn:getColor(), boardEnd, boardEnd - 4 * step, step, xOffset, yOffset, 8, j + 3)
    else
        knight = Knight(pawn:getColor(), -step, 0, step, xOffset, yOffset, 8, j)
        bishop = Bishop(pawn:getColor(), -step , step, step, xOffset, yOffset, 8, j + 1)
        rook = Rook(pawn:getColor(), -step, 2 * step, step, xOffset, yOffset, 8, j + 3)
        queen = Queen(pawn:getColor(), -step, 3 * step, step, xOffset, yOffset, 8, j + 3)
    end
    table.insert(self.promotionPieces, knight)
    table.insert(self.promotionPieces, bishop)
    table.insert(self.promotionPieces, rook)
    table.insert(self.promotionPieces, queen)
end

function Board:draw()
    self:drawBackground()
    for i = 1, #self.pieces do
        if self.pressed ~= i then
            self.pieces[i]:draw()
        end
    end

    for i = 1, #self.promotionPieces do
        if self.pressed ~= i then
            self.promotionPieces[i]:draw()
        end
    end

    -- draws pressed piece on top
    if self.pressed ~= -1 then
        self.pieces[self.pressed]:draw()
        love.graphics.print(self.pieces[self.pressed]:getName(), 0, 50)
        local x,y = self.pieces[self.pressed]:getActualPos()
        love.graphics.print(x..y , 0, 90)
    end
end

function Board:drawBackground()
    local scale, xPos, yPos = self.imageScale, 0, 0
    for i = 1, self.tiles / 2 do
        for j = 1, self.tiles do
            xPos = (2 * i - 2 + j % 2) * self.gridSize + self.xOffset
            yPos = (j - 1) * self.gridSize + self.yOffset
            love.graphics.draw(self.imageDark, xPos, yPos, 0, scale, scale)
            xPos = (2 * i - 2 + (j + 1) % 2) * self.gridSize + self.xOffset
            love.graphics.draw(self.imageLight, xPos, yPos, 0, scale, scale)
        end
    end
end

function Board:classicStart()
    self:whitePiecesDefault(self.pieces)
    self:blackPiecesDefault(self.pieces)
end

function Board:whitePiecesDefault(pieces)
    local step = self.gridSize
    local xOffset = self.xOffset
    local yOffset = self.yOffset
    local boardEnd = self.tiles * self.gridSize

    self:addPiece(Knight("w", step, 0, step, xOffset, yOffset, 1, 0))
    self:addPiece(Knight("w", boardEnd - 2 *step, 0, step, xOffset, yOffset, 6, 0))
    self:addPiece(Bishop("w", 2 * step, 0, step, xOffset, yOffset, 2, 0))
    self:addPiece(Bishop("w", boardEnd - 3 * step, 0, step, xOffset, yOffset, 5, 0))
    self:addPiece(Rook("w", 0, 0, step, xOffset, yOffset, 0, 0))
    self:addPiece(Rook("w", boardEnd - step, 0, step, xOffset, yOffset, 7, 0))
    self:addPiece(Queen("w", boardEnd - 4  * step, 0, step, xOffset, yOffset, 4, 0))
    self:addPiece(King("w", 3 * step, 0, step, xOffset, yOffset, 3, 0))
    for i = 0, self.tiles - 1 do
        self:addPiece(Pawn("w", i * step, step, step, xOffset, yOffset, i, 1))
    end
end

function Board:blackPiecesDefault(pieces)
    local step = self.gridSize
    local xOffset = self.xOffset
    local yOffset = self.yOffset
    local boardEnd = self.tiles * self.gridSize

    self:addPiece(Knight("b", step, boardEnd - step, step, xOffset, yOffset, 1, 7))
    self:addPiece(Knight("b", boardEnd - 2 *step, boardEnd - step, step, xOffset, yOffset, 6, 7))
    self:addPiece(Bishop("b",  2 * step, boardEnd - step, step, xOffset, yOffset, 2, 7))
    self:addPiece(Bishop("b",  boardEnd - 3 * step, boardEnd - step, step, xOffset, yOffset, 5,7))
    self:addPiece(Rook("b",  0, boardEnd - step, step, xOffset, yOffset, 0,7))
    self:addPiece(Rook("b",  boardEnd - step, boardEnd - step, step, xOffset, yOffset, 7, 7))
    self:addPiece(Queen("b", boardEnd - 4  * step  , boardEnd - step, step, xOffset, yOffset, 4, 7))
    self:addPiece(King("b", 3 * step , boardEnd - step, step, xOffset, yOffset, 3, 7))
    for i = 0, self.tiles - 1 do
        self:addPiece(Pawn("b", i * step,  boardEnd - 2 * step , step, xOffset, yOffset, i , 6))
    end
end

function Board:getLastMove()
    return self.lastMove
end

function Board:addPiece(piece)
    table.insert(self.pieces, piece)
end

function Board:getPieces()
    return self.pieces
end

function Board:revertLastMove()
    local x, y = self.lastMove:getStart()
    self.pieces[self.moved]:move(x, y)
    self.newMove = false
end

function Board:removeCapturedPiece(piece)
    local index = self:getIndexFrom(piece, self:getPieces())
    table.remove(self:getPieces(), index)
end

function Board:isNewMove()
    if self.newMove then
        self.newMove = false
        return true
    end
    return false
end

function Board:getMoved()
    return self.moved
end

function Board:getPressed()
    return self.pressed
end

function Board:getKing(color)
    if color == "w" then
        for key, piece in pairs(self.pieces) do
            if  piece:getName() == "king" and piece:getColor() == "w" then
                return piece
            end
        end
    else
        for key, piece in pairs(self.pieces) do
            if  piece:getName() == "king" and piece:getColor() == "b" then
                return piece
            end
        end
    end
end

function Board:getIndexFrom(value, table)
    local index={}
    for k,v in pairs(table) do
       index[v]=k
    end
    return index[value]
end