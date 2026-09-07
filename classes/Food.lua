-- Food.lua

Food = {}
Food.__index = Food


function Food:new()

    local instance = setmetatable({}, Food)

    instance.x = 400
    instance.y = 300

    return instance

end


function Food:setPosition(x, y)

    self.x = x
    self.y = y

end


function Food:getPosition()

    return self.x, self.y

end


function Food:draw()

    -- PLACEHOLDER:
    -- Dibujar la comida

    love.graphics.circle(
        "fill",
        self.x,
        self.y,
        10
    )

end


return Food