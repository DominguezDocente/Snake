-- Board.lua

Board = {}
Board.__index = Board


function Board:new(width, height, cellSize)

    local instance = setmetatable({}, Board)

    instance.width = width
    instance.height = height
    instance.cellSize = cellSize

    return instance

end


function Board:isInside(x, y)

    return x >= 0
        and x < self.width
        and y >= 0
        and y < self.height

end


function Board:getRandomPosition()

    local cols = math.floor(self.width / self.cellSize)
    local rows = math.floor(self.height / self.cellSize)

    local col = love.math.random(0, cols - 1)
    local row = love.math.random(0, rows - 1)

    return col * self.cellSize, row * self.cellSize

end


function Board:draw()

    love.graphics.setColor(0.1, 0.1, 0.12)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)

    love.graphics.setColor(0.35, 0.35, 0.4)
    love.graphics.rectangle("line", 0, 0, self.width, self.height)

    love.graphics.setColor(1, 1, 1)

end


return Board
