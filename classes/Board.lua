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

    -- PLACEHOLDER:
    -- Generar una posición aleatoria dentro de los límites del tablero

end


function Board:draw()

    -- PLACEHOLDER:
    -- Dibujar el área de juego

    love.graphics.rectangle(
        "line",
        0,
        0,
        self.width,
        self.height
    )

end


return Board