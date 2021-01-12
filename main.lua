Object = require "classic"
require "board"

function love.load()
    board = Board()
end

function love.update(dt)
    board:update(dt)
end

function love.draw()
    board:draw()
end