-- Game.lua

local Snake = require("classes.Snake")
local Food = require("classes.Food")
local Board = require("classes.Board")


Game = {}
Game.__index = Game


-- Constructor
function Game:new()

    local instance = setmetatable({}, Game)

    instance.snake = Snake:new()
    instance.food = Food:new()
    instance.board = Board:new(800, 600, 20)

    instance.score = 0

    instance.currentState = "TitleState"

    return instance

end


-- Inicializar el juego
function Game:initialize()

    -- PLACEHOLDER:
    -- Inicializar los objetos y preparar el estado inicial de la partida

end


-- Actualizar la lógica del juego
function Game:update(dt)

    if self:isPlaying() then

        self.snake:update(dt)

        self:checkCollisions()

    end

end


-- Dibujar los elementos del juego
function Game:draw()

    self.board:draw()

    self.snake:draw()

    self.food:draw()

    -- PLACEHOLDER:
    -- Dibujar el puntaje

end


-- Reiniciar la partida
function Game:restart()

    self.score = 0

    self.snake:reset()

    self:generateFood()

    self:changeState("PlayState")

end


-- Generar una nueva posición para la comida
function Game:generateFood()

    -- PLACEHOLDER:
    -- Generar una posición aleatoria dentro del Board y verificar que no esté ocupada por Snake

end


-- Revisar las colisiones del juego
function Game:checkCollisions()

    -- PLACEHOLDER:
    -- Revisar colisión con los límites del Board
    -- Revisar colisión de Snake consigo misma
    -- Revisar colisión entre Snake y Food

end


-- Cambiar el estado del juego
function Game:changeState(newState)

    self.currentState = newState

end


-- Obtener el estado actual
function Game:getState()

    return self.currentState

end


-- Verificar si el juego está en ejecución
function Game:isPlaying()

    return self.currentState == "PlayState"

end

function Game:handleInput()

    if not self:isPlaying() then
        return
    end

    if love.keyboard.isDown("up") then
        self.snake:changeDirection("UP")

    elseif love.keyboard.isDown("down") then
        self.snake:changeDirection("DOWN")

    elseif love.keyboard.isDown("left") then
        self.snake:changeDirection("LEFT")

    elseif love.keyboard.isDown("right") then
        self.snake:changeDirection("RIGHT")
    end

end


return Game