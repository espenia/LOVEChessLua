Object = require "classic"
require "board"
require "game"
require "menu"

if pcall(require, "lldebugger") then require("lldebugger").start() end
if pcall(require, "mobdebug") then require("mobdebug").start() end

function love.load()
    love.graphics.setBackgroundColor(51/255, 0/255, 17/255, 0)
    game = Game()
    board = Board()
    ingameMenu = Menu(683, 80, 100, 500)
    ingameMenu:setOptions({"restart", "draw", "exit"}, true)
end

function love.update(dt)
    board:update(dt)
    if board:isNewMove() then
        if game:validateMove(board:getPieces(), board:getMoved(), board:getLastMove(), board) then
            game:nextTurn()
            --board:removeCapturedPiece()
            
        else
            board:revertLastMove()
        end
    end
    ingameMenu:updateSelection()
end

function love.draw()
    game:showCurrentTurn(game:getTurn())
    board:draw()
    ingameMenu:draw()
end


function love.keypressed(key, u)
    --Debug
    if key == "rctrl" then --set to whatever key you want to use
       debug.debug()
    end
 end