-- Food.lua

Food = {}
Food.__index = Food


function Food:new()

    local instance = setmetatable({}, Food)

    instance.x = 400
    instance.y = 300
    instance.radius = 8

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

    local cs = 20
    love.graphics.setColor(0.9, 0.25, 0.25)
    love.graphics.circle(
        "fill",
        self.x + cs / 2,
        self.y + cs / 2,
        self.radius
    )
    love.graphics.setColor(1, 1, 1)

end


return Food
