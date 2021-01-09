Piece = Object:extend()


function Piece:new()
    self.image = love.graphics.newImage("assets/" + self.name + "-" + self.color + ".png")
    self.x = 300
    self.y = 20
    self.speed = 500
    self.width = self.image:getWidth() 
end

function Piece:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
end

function Piece:draw()
    love.graphics.draw(self.image, self.x, self.y)
end


function Piece:setColor(i)
    if i == 0 then
        self.color = "white"
    else
        self.color = "black"
    end
end