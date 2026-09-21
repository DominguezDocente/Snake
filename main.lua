local Game = require("classes.Game")

local game


function love.load()

    game = Game:new()
    game:initialize()

end


function love.update(dt)

    game:handleInput()
    game:update(dt)

end


function love.draw()

    love.graphics.clear(0.05, 0.05, 0.08)
    game:draw()

end


function love.keypressed(key)

    game:keypressed(key)

end
