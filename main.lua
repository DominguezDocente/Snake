local Game = require("classes.Game")

local game

function love.load()

    game = Game:new()

end


function love.update(dt)

    game:handleInput()

    game:update(dt)

end


function love.draw()

    love.graphics.clear()

    game:draw()

end