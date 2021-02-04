Chess = Object:extend()

require "board"
require "game"
require "menu"
require "effect"
require "title"

function Chess:new()
    self.backgroundColor = {r = 51/255, g = 0/255, b = 17/255, a = 0}
    self.game = Game()
    self.board = Board()
    self.particles = Effect()
end

function Chess:load()
    self:initBackground()
    self:initBoard()
    self:initMenus()
end

function Chess:initBackground()
    local r = self.backgroundColor["r"]
    local g = self.backgroundColor["g"]
    local b = self.backgroundColor["b"]
    local a = self.backgroundColor["a"]
    love.graphics.setBackgroundColor(r, g, b, a)
    self.particles:particle()
end

function Chess:initBoard()
    self.initialTiles = 8
    self.initialBoardWindowRatio = 0.8
    self.initialGridSize = love.graphics.getHeight() * self.initialBoardWindowRatio / self.initialTiles
end

function Chess:initMenus()
    self.ingameMenu = Menu(683, 100, 500, true)
    self.ingameMenu:setOptions({"restart", "draw", "exit"}, true)
    self.title = Title("LOVE \nChess \nLua", 40, 32, 20, true, 0.1)
    self.mainTitle = Title("Love \nChess \nLua", 0, 0, 100, true, 0.1)
    self.mainTitle:center(false, true)
    self.startMenu = Menu(400, 100, 500, true)
    self.startMenu:setOptions({"start", "exit"}, true)
    self.startMenu:center(false, true)
    self.drawTitle = Title("Draw", 0, 0, 100, true, 0.1)
    self.drawTitle:center(true, true)
end

function Chess:update(dt)
    self.board:update(dt, self.game:getTurn())
    if self.game:getStatus() == "playing" then
        self:updatePlays()
    elseif self.game:getStatus() == "main" then
        self:updateMainMenu()
    elseif self.game:getStatus() == "draw" then
        self:updateDrawGame()
    end
    self.particles:particleEmit(dt)
end

function Chess:updatePlays()
    if self.board:isNewMove() then
        self:resolveMove()
    end    
    if self.board:isNewPromotion() then
        self.game:nextTurn()     
    end
    self:updateIngameMenu()
end

function Chess:resolveMove()
    local isValidMove = self.game:validateMove(self.board)
    if self.board:isNotWaitingForPromotion() and isValidMove then
        local pawn = self.game:isPawnPromotion(self.board:getPieces(), self.game:getTurn())
        if pawn then
            self.board:spawnPromotionPieces(pawn)
        else
            self.game:nextTurn()
        end
    else
        self.board:revertLastMove()
    end
end

function Chess:updateIngameMenu()
    self.ingameMenu:updateSelection()
    local option = self.ingameMenu:optionRequested()
    if option == "restart" then
        love.event.quit( "restart" )
    elseif option == "draw" then
        self.game:drawGame()
    elseif option == "exit" then
        love.event.quit()
    end
end

function Chess:updateMainMenu()
    self.startMenu:updateSelection()
    local option = self.startMenu:optionRequested()
    if option == "start" then
        self.game:startGame()
    elseif option == "exit" then
        love.event.quit()
    end
end

function Chess:updateDrawGame()
    self.ingameMenu:updateSelection()
    local option = self.ingameMenu:optionRequested()
    if option == "restart" then
        love.event.quit( "restart" )
    elseif option == "draw" then
        self.game:drawGame()
    elseif option == "exit" then
        love.event.quit()
    end
end

function Chess:draw()
    self.particles:particleDraw()
    if self.game:getStatus() == "playing" then
        self:drawPlayingMode()
    elseif self.game:getStatus() == "main" then
        self:drawMainMenu()
    elseif self.game:getStatus() == "draw" then
        self:drawDrawState()
    end
end

function Chess:drawPlayingMode()
    local menuX, menuY = self.ingameMenu:getMenuEnd()
    self.game:showCurrentTurn(self.game:getTurn(), menuX, menuY)
    love.graphics.print(self.board:getMoved(), 10, 100)
    love.graphics.print(#self.board:getPieces(), 10, 150)
    self.board:draw()
    self.ingameMenu:draw()
    self.title:draw()
end

function Chess:drawMainMenu()
    self.mainTitle:draw()
    self.startMenu:draw()
end

function Chess:drawDrawState()
    self.board:draw()
    self.title:draw()
    self.drawTitle:draw()
    self.ingameMenu:draw()
end
    
function Chess:resize()
    local gridSize = love.graphics.getHeight() * self.initialBoardWindowRatio / self.initialTiles
    self.board:updateOnResize(self.initialBoardWindowRatio)
    local x = (love.graphics.getWidth() + self.initialTiles * gridSize) / 2 + 20
    local y = love.graphics.getHeight() * 0.1
    self.ingameMenu:updateOnResize(x, y)
    x = (love.graphics.getWidth() - gridSize * self.initialTiles) / 2 - self.title:getBoxWidth() - 20 
    self.title:updateOnResize(x, y)
    self.mainTitle:center(false, true)
    self.startMenu:center(false, true)
    self.drawTitle:center(true, true)
end