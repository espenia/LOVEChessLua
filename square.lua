Square = Object:extend()

function Square:new(x, y)
    self.x = x
    self.y = y
end

function Square:set(x, y)
    self.x = x
    self.y = y
end

function Square:get()
    return self.x, self.y
end