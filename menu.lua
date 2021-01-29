Menu = Object:extend()

function Menu:new(x, y, width, height)
    self.x = x
    self.y = y
    self.offset = 20
    self.width = width
    self.height = height
    self.backgroundColor = {0, 0, 0, 0.2}
    self.unselectedColor = {10, 10, 10, 0.4}
    self.selectedColor = {1, 1, 1, 1}
    self.optionSpacing = 20
    self.options = {}
    self.currentSelected = 0
    self.down = false
    self.up = false
    self.length = 0
end

function Menu:drawBackground()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.backgroundColor)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height )
    love.graphics.setColor(r, g, b, a)
end

-- options is a table of strings
function Menu:setOptions(options, fixHeight)
    self.options = options
    self.length = self:len()
    if fixHeight then
        self.height = self.offset + self.length * self.optionSpacing + self.offset
    end
end

function Menu:drawOptions()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.unselectedColor)
    local x, y = self.x + self.offset, self.y + self.offset
    for key, option in pairs(self.options) do
        if self:isSelected(option) then 
            love.graphics.setColor(self.selectedColor)
            love.graphics.print(option, x, y)
            love.graphics.setColor(self.unselectedColor)
        else
            love.graphics.print(option, x, y)
        end
        y = y + self.optionSpacing
    end
    love.graphics.setColor(r, g, b, a)
end

function Menu:draw()
    self:drawBackground()
    self:drawOptions()
    love.graphics.print(self.currentSelected, 10, 500)
end

function Menu:isSelected(option)
    if self.currentSelected == 0 then return false end
    return self.options[self.currentSelected] == option
end

function Menu:updateSelection()
    local i = self.currentSelected
    if self:downPressed() and i < self.length then
        self.currentSelected = i + 1
    elseif self:upPressed() and i > 0 then
        self.currentSelected = i - 1
    end
end

function Menu:downPressed()
    local lastDown = self.down
    self.down = love.keyboard.isDown('down')
    return (not lastDown) and self.down
end

function Menu:upPressed()
    local lastUp = self.up
    self.up = love.keyboard.isDown('up')
    return (not lastUp) and self.up
end

function Menu:len()
    local length = 0
        for key, option in pairs(self.options) do
            length = length + 1
        end
    return length
end