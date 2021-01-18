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
        if game:validateMove(board:getPieces(), board:getMoved(), board:getLastMove()) then
            game:nextTurn()
            --board:removeCapturedPiece()
            
        else
            board:revertLastMove()
        end
    end
end

function love.draw()
    board:draw()
end


function love.keypressed(key, u)
    --Debug
    if key == "rctrl" then --set to whatever key you want to use
       debug.debug()
    end
 end