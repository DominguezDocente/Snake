-- Snake.lua

local SnakeSegment = require("classes.SnakeSegment")


Snake = {}
Snake.__index = Snake


function Snake:new()

    local instance = setmetatable({}, Snake)

    instance.segments = {}

    instance.direction = "RIGHT"

    instance.speed = 5

    instance.moveTimer = 0

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

    -- PLACEHOLDER:
    -- Mover la cabeza según la dirección y actualizar los segmentos del cuerpo

end


function Snake:changeDirection(direction)

    -- PLACEHOLDER:
    -- Validar que no se cambie directamente a la dirección opuesta

    self.direction = direction

end


function Snake:grow()

    -- PLACEHOLDER:
    -- Agregar un nuevo SnakeSegment

end


function Snake:checkSelfCollision()

    -- PLACEHOLDER:
    -- Verificar si la cabeza colisiona con algún segmento del cuerpo

    return false

end


function Snake:getHead()

    return self.segments[1]

end


function Snake:draw()

    -- PLACEHOLDER:
    -- Dibujar todos los segmentos de la serpiente

end


function Snake:reset()

    -- PLACEHOLDER:
    -- Restablecer posición y tamaño inicial

end


return Snake