-- Snake.lua

local SnakeSegment = require("classes.SnakeSegment")


Snake = {}
Snake.__index = Snake


function Snake:new()

    local instance = setmetatable({}, Snake)

    instance.segments = {}
    instance.direction = "RIGHT"
    instance.nextDirection = "RIGHT"
    instance.speed = 8
    instance.moveTimer = 0
    instance.cellSize = 20
    instance.pendingGrow = 0

    return instance

end


function Snake:update(dt)

    self.moveTimer = self.moveTimer + dt

    local moveInterval = 1 / self.speed

    if self.moveTimer >= moveInterval then

        self:move()
        self.moveTimer = 0

    end

end


function Snake:move()

    self.direction = self.nextDirection

    local head = self.segments[1]
    local x, y = head.x, head.y
    local s = self.cellSize

    if self.direction == "UP" then
        y = y - s
    elseif self.direction == "DOWN" then
        y = y + s
    elseif self.direction == "LEFT" then
        x = x - s
    elseif self.direction == "RIGHT" then
        x = x + s
    end

    table.insert(self.segments, 1, SnakeSegment:new(x, y))

    if self.pendingGrow > 0 then
        self.pendingGrow = self.pendingGrow - 1
    else
        table.remove(self.segments)
    end

end


function Snake:changeDirection(direction)

    local opposite = {
        UP = "DOWN",
        DOWN = "UP",
        LEFT = "RIGHT",
        RIGHT = "LEFT"
    }

    if direction ~= opposite[self.direction] then
        self.nextDirection = direction
    end

end


function Snake:grow()

    self.pendingGrow = self.pendingGrow + 1

end


function Snake:checkSelfCollision()

    local head = self.segments[1]

    for i = 2, #self.segments do
        local s = self.segments[i]
        if s.x == head.x and s.y == head.y then
            return true
        end
    end

    return false

end


function Snake:occupies(x, y)

    for _, s in ipairs(self.segments) do
        if s.x == x and s.y == y then
            return true
        end
    end

    return false

end


function Snake:getHead()

    return self.segments[1]

end


function Snake:draw()

    for i, s in ipairs(self.segments) do
        if i == 1 then
            love.graphics.setColor(0.2, 0.8, 0.3)
        else
            love.graphics.setColor(0.15, 0.6, 0.25)
        end
        love.graphics.rectangle("fill", s.x, s.y, self.cellSize - 1, self.cellSize - 1)
    end

    love.graphics.setColor(1, 1, 1)

end


function Snake:reset()

    self.segments = {}
    self.direction = "RIGHT"
    self.nextDirection = "RIGHT"
    self.moveTimer = 0
    self.pendingGrow = 0

    local startX = 10 * self.cellSize
    local startY = 10 * self.cellSize

    for i = 0, 2 do
        table.insert(self.segments, SnakeSegment:new(startX - i * self.cellSize, startY))
    end

end


return Snake
