function love.load()
    Object = require "classic"
    require "piece"
    require "pawn"
    pawn = Pawn()
end

function love.update(dt)
    pawn:update(dt)
end

function love.draw()
    pawn:draw()
end