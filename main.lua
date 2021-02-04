Object = require "classic"
require "chess"

if pcall(require, "lldebugger") then require("lldebugger").start() end
if pcall(require, "mobdebug") then require("mobdebug").start() end

function love.load()
    chess = Chess()
    chess:load()
end

function love.update(dt)
    chess:update(dt)
end

function love.draw()
    chess:draw()
end

function love.resize(w, h)
    chess:resize()
end

function love.keypressed(key, u)
    --Debug
    if key == "rctrl" then --set to whatever key you want to use
       debug.debug()
    end
 end