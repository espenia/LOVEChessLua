Menu = Object:extend()

function Menu:new(x, y, width, height, needsConfirm)
    self.x = x
    self.y = y
    self.offset = 20
    self.width = width
    self.height = height
    self.backgroundColor = {0, 0, 0, 0.2}
    self.confirmBackgroundColor = {0, 0, 0, 0.8}
    self.unselectedColor = {10, 10, 10, 0.4}
    self.selectedColor = {1, 1, 1, 1}
    self.optionSpacing = 20
    self.options = {}
    self.currentSelected = 0
    self.down = false
    self.up = false
    self.length = 0
    self.confirmPopped = false
    self.needsConfirm = needsConfirm
    self.confirmTextSize = 40
    self.confirmed = false
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
    self:drawConfirmWindow()
    love.graphics.print(self.currentSelected, 10, 500)
end

function Menu:drawConfirmWindow()
    if self.confirmPopped then
        self:drawBackgroundConfirmWindow()
        local request = self.options[self.currentSelected]
        local myFont = love.graphics.getFont()
        love.graphics.setFont(love.graphics.newFont(self.confirmTextSize))
        local font = love.graphics.getFont()
        local fontWidth = font:getWidth(request .. "?")
        local x = (love.graphics.getWidth() - fontWidth) / 2
        local y = love.graphics.getWidth() / 3
        love.graphics.print(request .. "?", x, y)
        love.graphics.setFont(love.graphics.newFont(self.confirmTextSize / 2))
        local font = love.graphics.getFont()
        local fontWidth = font:getWidth(request .. "?")
        local fontWidth = font:getWidth("Y / N")
        local x = (love.graphics.getWidth() - fontWidth) / 2
        love.graphics.print("Y / N", x, y + self.confirmTextSize * 1.3)
        love.graphics.setFont(myFont)
    end
end

function Menu:drawBackgroundConfirmWindow()
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    local spaceWidth = math.floor(windowWidth / 3.4)
    local spaceHeight = math.floor(windowHeight / 3)
    local width = windowWidth - 2 * spaceWidth
    local height = windowHeight - 2 * spaceHeight
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.confirmBackgroundColor)
    love.graphics.rectangle("fill", spaceWidth, spaceHeight, width, height)
    love.graphics.setColor(r, g, b, a)
end

function Menu:isSelected(option)
    if self.currentSelected == 0 then return false end
    return self.options[self.currentSelected] == option
end

function Menu:updateSelection()
    local i = self.currentSelected
    if self.confirmPopped then 
        if love.keyboard.isDown('y') then
            self.confirmed = true
        elseif love.keyboard.isDown('n') then
            self.confirmPopped = false
        end
    else
        if self:downPressed() and i < self.length then
            self.currentSelected = i + 1
        elseif self:upPressed() and i > 0 then
            self.currentSelected = i - 1
        end
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

function Menu:optionRequested()
    if self.confirmPopped then
        if self.confirmed then
            return self.options[self.currentSelected]
        end
    else
        if love.keyboard.isDown('return') and self.currentSelected then
            self.confirmPopped = true and self.needsConfirm
        end
    end
    return nil
end