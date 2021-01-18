Square = Object:extend()

function Square:new()
    self.x = 0
    self.y = 0
end

function Square:set(x, y)
    self.x = x
    self.y = y
end

function Square:get()
    return self.x, self.y
end