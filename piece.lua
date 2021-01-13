Piece = Object:extend()


function Piece:new(color, x, y, gridSize, xOffset, yOffset)
    self.gridSize = gridSize
    self.widthScale = 0.17
    self.heightScale = 0.17
    self.width = self.image:getWidth() * self.widthScale
    self.height = self.image:getHeight() * self.heightScale
    self.x = x + (self.gridSize - self.width) / 2
    self.y = y + (self.gridSize - self.height) / 2
    self.speed = 500
    self.clicked = false
    self.color = color
    self.xOffset = xOffset
    self.yOffset = yOffset
end

function Piece:update(dt)
    self:isPressed()
    self:drag()
end

function Piece:keyboardMove()
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
end

function Piece:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.widthScale, self.heightScale)
end

function Piece:isPressed()
    local delta = 50
    if love.mouse.isDown(1) then
        local x, y = love.mouse.getPosition()
        if  (x > self.x + self.width / 2 - delta) and
            (x < self.x + self.width / 2 + delta) and
            (y > self.y + self.height / 2 - delta) and
            (y < self.y + self.height / 2 + delta) then
            self.clicked = true
        end
    else
        self.clicked = false
    end
end

function Piece:drag()
    if self.clicked then
        self.x, self.y = love.mouse.getPosition()
        self.x = math.floor((self.x - self.xOffset) / self.gridSize) * self.gridSize
        self.x = self.x + self.xOffset + (self.gridSize - self.width) / 2
        self.y = math.floor((self.y - self.yOffset) / self.gridSize) * self.gridSize
        self.y = self.y + self.yOffset + (self.gridSize - self.height) / 2
    end
end

function Piece:setColor(i)
    if i == 0 then
        self.color = "white"
    else
        self.color = "black"
    end
end