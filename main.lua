Object = require "classic"
require "board"
require "game"

if pcall(require, "lldebugger") then require("lldebugger").start() end
if pcall(require, "mobdebug") then require("mobdebug").start() end

function love.load()
    game = Game()
    board = Board()
end

function love.update(dt)
    board:update(dt)
    if board:isNewMove() then
        if game:validateMove(board:getPieces(), board:getMoved(), board:getLastMove(), board) then
            game:nextTurn()
        else
            board:revertLastMove()
        end
    end
end

function love.draw()
    game:showCurrentTurn(game:getTurn())

    -- local king = board:getKing("w")
    -- if king == nil then
    --     love.graphics.print("bum bum the white king is dead", 10, 100)
    -- else
    --     love.graphics.print("white king alive", 10, 100)
    -- end
    -- if  game:isKingInCheck(king, board:getPieces()) then
    --     love.graphics.print("white king is in check", 10, 200)
    -- else
    --     love.graphics.print("white king is not in check", 10 , 200)
    -- end

    -- king = board:getKing("b")
    -- if king == nil then
    --     love.graphics.print("bum bum the black king is dead", 10, 400)
    -- else
    --     love.graphics.print("black king alive", 10, 400)
    -- end
    -- if  game:isKingInCheck(king, board:getPieces()) then
    --     love.graphics.print("black king is in check", 10, 300)
    -- else
    --     love.graphics.print("black king is not in check", 10 , 300)
    -- end

    board:draw()
end


function love.keypressed(key, u)
    --Debug
    if key == "rctrl" then --set to whatever key you want to use
       debug.debug()
    end
 end