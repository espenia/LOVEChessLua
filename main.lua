Object = require "classic"
require "board"
require "game"

function love.load()
    game = Game()
    board = Board()
end

function love.update(dt)
    board:update(dt)
    if board:isNewMove() then
        if game:validateMove(board:getPieces(), board:getMoved(), board:getLastMove()) then
            board:removeCapturedPiece()
        else
            board:revertLastMove()
        end
    end
end

function love.draw()
    board:draw()
end