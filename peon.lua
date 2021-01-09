Peon = Object:extend()


function Peon:new()
    self.image = love.graphics.newImage("assets/peon-black.png")
    self.x = 300
    self.y = 20
    self.speed = 500
    self.width = self.image:getWidth() 
end

function Peon:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
end

function Peon:draw()
    love.graphics.draw(self.image, self.x, self.y)
end


function Peon:color()
    
end