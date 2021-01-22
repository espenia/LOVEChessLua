Piece = Object:extend()

require "square"

function Piece:new(color, x, y, gridSize, xOffset, yOffset, posX, posY)
    local imgGridRatio = 0.9 -- img has 90% width of grid width
    self.gridSize = gridSize
    self.heightScale = gridSize * imgGridRatio / self.image:getHeight()
    self.widthScale = self.heightScale -- squared
    self.width = self.image:getWidth() * self.widthScale
    self.height = self.image:getHeight() * self.heightScale
    self.xOffset = xOffset
    self.yOffset = yOffset
    self.x = x + self.xOffset + (self.gridSize - self.width) / 2
    self.y = y + self.yOffset + (self.gridSize - self.height) / 2
    self.speed = 500
    self.clicked = false
    self.color = color
    self.drawOffset = 5
    self.actualPos = Square()
    self.actualPos:set(posX, posY)
    self.captured = false
end

function Piece:getColor()
    return self.color
end

function Piece:toBeCaptured(toBeCaptured)
    self.captured = toBeCaptured
end

function Piece:isCaptured()
    return self.captured
end

-- function Piece:setColor(i)
--     if i == 0 then
--         self.color = "w"
--     else
--         self.color = "b"
--     end
-- end

function Piece:move(x, y)
    self.x = x * self.gridSize + self.xOffset + (self.gridSize - self.width) / 2
    self.y = y * self.gridSize + self.yOffset + (self.gridSize - self.height) / 2
end

function Piece:update(dt)
    self:isPressed()
    self:drag()
end

function Piece:getChessPos()
    local x = math.floor((self.x - self.xOffset) / self.gridSize)
    local y = math.floor((self.y - self.yOffset) / self.gridSize)
    return x,y
end

function Piece:getName()
    return self.name
end

function Piece:keyboardMove()
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
end

function Piece:draw()
    local lift = 0
    if self.clicked then lift = self.drawOffset end
    love.graphics.draw(self.image, self.x, self.y - lift, 0, self.widthScale, self.heightScale)
end

function Piece:isPressed()
    local delta = self.gridSize / 3.3
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
    local x,y = 0,0
    if self.clicked then
        x, y = love.mouse.getPosition()
        if self:mouseOnBoard(x, y) then
            x = math.floor((x - self.xOffset) / self.gridSize) * self.gridSize
            self.x = x + self.xOffset + (self.gridSize - self.width) / 2
            y = math.floor((y - self.yOffset) / self.gridSize) * self.gridSize
            self.y = y + self.yOffset + (self.gridSize - self.height) / 2
        end
    end
end

function Piece:mouseOnBoard(x, y)
    local xAxisOnBoard = x > self.xOffset and x < self.xOffset + 8 * self.gridSize
    local yAxisOnBoard = y > self.yOffset and y < self.yOffset + 8 * self.gridSize
    return xAxisOnBoard and yAxisOnBoard
end

function Piece:setColor(i)
    if i == 0 then
        self.color = "w"
    else
        self.color = "b"
    end
end

function Piece:updatePos(lastMove)
    xf,yf = lastMove:getEnd()
    self.actualPos:set(xf,yf)
end

function Piece:getColor()
    return self.color
end

function Piece:checkPos(colorf, xf, yf)
    myX, myY = self.actualPos:get();

    if myX == xf and myY == yf and self.color == colorf then
        return true
    else
        return false
    end
end

function Piece:checkCoordinates(xf, yf)
    myX, myY = self.actualPos:get();

    if myX == xf and myY == yf then
        return true
    else
        return false
    end
end

function Piece:getActualPos()
    return self.actualPos:get()
end

function Piece:canCapture()
    return true
end
