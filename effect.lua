Effect = Object:extend()

function Effect:new()
    self.effect = nil
end

function Effect:particle()
    local img = love.graphics.newImage("assets/knight-black.png")
    self.effect = love.graphics.newParticleSystem(img, 800)
    self.effect:setParticleLifetime(15, 15)
    self.effect:setLinearAcceleration(0, 10, 0, 20)
    self.effect:setSpeed(0.001)
    self.effect:setEmissionRate(0.00001)
    self.effect:setSpin(1, 2)
    self.effect:setEmissionArea('uniform', 4000, 0, 0, false)
    self.effect:setSizes(0.1, 0.1)
    self:particleSystemInAdvancedState()
end

--fast forward particle system
function Effect:particleSystemInAdvancedState()
    for i = 0, 500 do
        self.effect:update(0.1)
        self.effect:emit(1)
    end
end

function Effect:particleEmit(dt)
    self.effect:update(dt)
    self.effect:emit(1)
end

function Effect:particleDraw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 1, 1, 0.2)
    love.graphics.draw(self.effect, love.graphics.getWidth() * 0.5, -100)
    love.graphics.setColor(r, g, b, a)
end