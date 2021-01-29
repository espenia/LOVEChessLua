Title = Object:extend()

function Title:new(text, x, y, size, drawBox, marginRatio)
    self.margin = marginRatio
    self.text = text
    self.x = x
    self.y = y
    self.size = size
    self.drawBox = drawBox --bool
    self.backgroundColor = {0, 0, 0, 0.2}
    self.font = love.graphics.newFont(self.size)
    self.fontWidth = self:getFontWidth()
    self.fontHeight = self:getFontHeight()
    self.lines = self:countNewLines(self.text)
    self.marginWidth = self.fontWidth * self.margin
    self.marginHeight = self.fontHeight * self.margin
    self.boxWidth = (self.fontWidth) + 2 * self.marginWidth
    self.boxHeight = self.lines * (self.fontHeight + self.marginHeight)
end

function Title:center(x, y)
    if x then
        self.x = love.graphics.getWidth() / 2 - self.boxWidth / 2
    end
    if y then
        self.y = love.graphics.getHeight() / 2 - self.boxHeight / 2
    end
end

function Title:getFontWidth()
    return self.font:getWidth(self.text)
end

function Title:getFontHeight()
    return self.font:getHeight(self.text)
end

function Title:draw()
    if self.drawBox then
        self:drawBackground()
    end
    self:drawText()
end

function Title:countNewLines(text)
    local _, lines = string.gsub(text, "\n", "\n")
    return lines + 1
end

function Title:drawBackground()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.backgroundColor)
    love.graphics.rectangle("fill", self.x, self.y, self.boxWidth, self.boxHeight)
    love.graphics.setColor(r, g, b, a)
end

function Title:drawText()
    local lastFont = love.graphics.getFont()
    love.graphics.setFont(self.font)
    love.graphics.print(self.text, self.x + self.marginWidth, self.y + self.marginHeight)
    love.graphics.setFont(lastFont)
end

function Title:updateOnResize(x, y)
    self.x = x
    self.y = y
end

function Title:getBoxWidth()
    return self.boxWidth
end
