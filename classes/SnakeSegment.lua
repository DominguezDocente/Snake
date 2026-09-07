-- SnakeSegment.lua

SnakeSegment = {}
SnakeSegment.__index = SnakeSegment


function SnakeSegment:new(x, y)

    local instance = setmetatable({}, SnakeSegment)

    instance.x = x
    instance.y = y

    return instance

end


function SnakeSegment:setPosition(x, y)

    self.x = x
    self.y = y

end


function SnakeSegment:getPosition()

    return self.x, self.y

end


return SnakeSegment