-- Wall.lua

Wall = {}
Wall.__index = Wall


function Wall:new(x, y, cellSize)

    local instance = setmetatable({}, Wall)

    instance.x = x
    instance.y = y
    instance.cellSize = cellSize or 20
    instance.alive = true

    return instance

end


function Wall:collides(hx, hy)

    return self.alive and self.x == hx and self.y == hy

end


-- Comportamiento base
function Wall:onHit(game)

    game:loseLife()

end


function Wall:draw()

    if not self.alive then
        return
    end

    love.graphics.setColor(0.55, 0.55, 0.6)
    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.cellSize - 1,
        self.cellSize - 1
    )
    love.graphics.setColor(1, 1, 1)

end


----------------------------------------------------------------
-- Pared sólida
----------------------------------------------------------------
SolidWall = {}
SolidWall.__index = SolidWall
setmetatable(SolidWall, { __index = Wall })


function SolidWall:new(x, y, cellSize)

    local instance = Wall:new(x, y, cellSize)
    setmetatable(instance, SolidWall)
    return instance

end


function SolidWall:onHit(game)

    game:loseLife()

end


function SolidWall:draw()

    if not self.alive then
        return
    end

    love.graphics.setColor(0.7, 0.35, 0.2)
    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.cellSize - 1,
        self.cellSize - 1
    )
    love.graphics.setColor(1, 1, 1)

end


return {
    Wall = Wall,
    SolidWall = SolidWall
}
