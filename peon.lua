Peon = Object:extend()


function Peon:new()
    self.image = love.graphics.newImage("assets/pawn-white.png")
    self.widthScale = 0.5
    self.heightScale = 0.5
    self.x = 300
    self.y = 20
    self.speed = 500
    self.width = self.image:getWidth() 
    self.clicked = false
end

function Peon:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
    self:isPressed()
    self:drag()
end

function Peon:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.widthScale, self.heightScale)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Test.", 10, 200)
    local x, y = love.mouse.getPosition()
    love.graphics.print(x, 10, 100)
    love.graphics.print(y, 10, 150)
    if self.clicked == true then
        love.graphics.print("down", 10, 250)
    end
end

function Peon:isPressed()
    local delta = 50
    if love.mouse.isDown(1) then
        local x, y = love.mouse.getPosition()
        if  (x > self.x - delta) and
            (x < self.x + delta) and
            (y > self.y - delta) and
            (y < self.y + delta) then
            self.clicked = true
        end
    else
        self.clicked = false
    end
end

function Peon:drag()
    if self.clicked then
        self.x, self.y = love.mouse.getPosition()
    end
end

function Peon:color()
    
end