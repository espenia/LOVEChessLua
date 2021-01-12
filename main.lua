function love.load()
    Object = require "classic"
    require "piece"
    require "peon"

    peon = Peon()

end

function love.update(dt)
    peon:update(dt)
end

function love.draw()
    peon:draw()
end






-- function love.load()
--     rook_white = love.graphics.newImage("assets/rook-white")
--     knight_white = love.graphics.newImage("assets/knight-white")
--     bishop_white = love.graphics.newImage("assets/bishop-white")
--     queen_white = love.graphics.newImage("assets/queen-white")
--     king_white = love.graphics.newImage("assets/king-white")
--     peon_white = love.graphics.newImage("assets/peon-white")
--     rook_black = love.graphics.newImage("assets/rook-black")
--     knight_black = love.graphics.newImage("assets/knight-black")
--     bishop_black = love.graphics.newImage("assets/bishop-black")
--     queen_black = love.graphics.newImage("assets/queen-black")
--     king_black = love.graphics.newImage("assets/king-black")
--     peon_black = love.graphics.newImage("assets/peon-black")
    
--     pieces = {"rook", "knight", "bishop", "queen", "king", "peon"}
-- end

-- function love.draw()
--     love.graphics.draw
-- end