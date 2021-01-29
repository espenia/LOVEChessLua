Object = require "classic"
require "board"
require "game"
require "menu"
require "effect"

if pcall(require, "lldebugger") then require("lldebugger").start() end
if pcall(require, "mobdebug") then require("mobdebug").start() end

function love.load()
    love.graphics.setBackgroundColor(51/255, 0/255, 17/255, 0)
    game = Game()
    board = Board()
    particles = Effect()
    particles:particle()
    ingameMenu = Menu(683, 80, 100, 500, true)
    ingameMenu:setOptions({"restart", "draw", "exit"}, true)
end

function love.update(dt)
    board:update(dt, game:getTurn())
    if board:isNewMove() then
        local isValidMove = game:validateMove(board:getPieces(), board:getMoved(), board:getLastMove(), board)
        if board:isNotWaitingForPromotion() and isValidMove then
            local pawn = game:isPawnPromotion(board:getPieces(), game:getTurn())
            if pawn then
                board:spawnPromotionPieces(pawn)
            else
                game:nextTurn()
            end
        else
            board:revertLastMove()
        end
    end    
    if board:isNewPromotion() then
        game:nextTurn()     
    end
    ingameMenu:updateSelection()
    local option = ingameMenu:optionRequested()
    if option == "restart" then
        love.event.quit( "restart" )
    elseif option == "draw" then
        love.event.quit( "restart" )
    elseif option == "exit" then
        love.event.quit()
    end
    particles:particleEmit(dt)
end

function love.draw()
    particles:particleDraw()
    game:showCurrentTurn(game:getTurn())
    love.graphics.print(board:getMoved(), 10, 100)
    love.graphics.print(#board:getPieces(), 10, 150)

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
    ingameMenu:draw()
end


function love.keypressed(key, u)
    --Debug
    if key == "rctrl" then --set to whatever key you want to use
       debug.debug()
    end
 end