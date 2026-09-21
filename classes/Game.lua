-- Game.lua

local Snake = require("classes.Snake")
local Food = require("classes.Food")
local Board = require("classes.Board")
local Levels = require("classes.levels")


Game = {}
Game.__index = Game


function Game:new()

    local instance = setmetatable({}, Game)

    instance.snake = Snake:new()
    instance.food = Food:new()
    instance.board = Board:new(800, 600, 20)

    instance.score = 0
    instance.lives = 3
    instance.level = 1
    instance.foodsEaten = 0
    instance.foodsPerLevel = 10
    instance.walls = {}

    instance.currentState = "TitleState"

    return instance

end


function Game:initialize()

    self.score = 0
    self.lives = 3
    self.level = 1
    self.foodsEaten = 0
    self:loadLevel(1)
    self.snake:reset()
    self:generateFood()
    self:changeState("TitleState")

end


function Game:loadLevel(n)

    self.level = n
    self.walls = Levels.build(n, self.board.cellSize)

end


function Game:update(dt)

    if self:isPlaying() then
        self.snake:update(dt)
        self:checkCollisions()
    end

end


function Game:draw()

    self.board:draw()

    for _, wall in ipairs(self.walls) do
        wall:draw()
    end

    if self.currentState ~= "TitleState" then
        self.snake:draw()
        self.food:draw()
    end

    -- HUD
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(
        "Score: " .. self.score
        .. "   Vidas: " .. self.lives
        .. "   Nivel: " .. self.level
        .. "   Comidas: " .. self.foodsEaten .. "/" .. self.foodsPerLevel,
        10, 10
    )

    -- Mensajes por estado
    local msg = nil
    if self.currentState == "TitleState" then
        msg = "SNAKE\nENTER = empezar"
    elseif self.currentState == "ServeState" then
        msg = "Nivel " .. self.level .. "\nSPACE = jugar"
    elseif self.currentState == "PauseState" then
        msg = "PAUSA\nP = continuar"
    elseif self.currentState == "GameOverState" then
        msg = "GAME OVER\nENTER = reiniciar"
    elseif self.currentState == "VictoryState" then
        msg = "VICTORIA!\nENTER = menu"
    end

    if msg then
        love.graphics.printf(msg, 0, 250, 800, "center")
    end

end


function Game:restart()

    self.score = 0
    self.lives = 3
    self.level = 1
    self.foodsEaten = 0
    self:loadLevel(1)
    self.snake:reset()
    self:generateFood()
    self:changeState("ServeState")

end


function Game:generateFood()

    local x, y
    local ok = false
    local tries = 0

    while not ok and tries < 200 do
        x, y = self.board:getRandomPosition()
        ok = true
        tries = tries + 1

        if self.snake:occupies(x, y) then
            ok = false
        end

        for _, wall in ipairs(self.walls) do
            if wall.alive and wall.x == x and wall.y == y then
                ok = false
                break
            end
        end
    end

    self.food:setPosition(x, y)

end


function Game:checkCollisions()

    local head = self.snake:getHead()
    if not head then
        return
    end

    -- Bordes del tablero (nivel 1 y 2)
    if not self.board:isInside(head.x, head.y) then
        self:loseLife()
        return
    end

    -- Paredes internas (polimorfismo: wall:onHit)
    for _, wall in ipairs(self.walls) do
        if wall:collides(head.x, head.y) then
            wall:onHit(self)
            return
        end
    end

    -- Choque consigo misma
    if self.snake:checkSelfCollision() then
        self:loseLife()
        return
    end

    -- Comida
    local fx, fy = self.food:getPosition()
    if head.x == fx and head.y == fy then
        self.score = self.score + 10
        self.foodsEaten = self.foodsEaten + 1
        self.snake:grow()
        self:generateFood()
        self:checkLevelUp()
    end

end


function Game:checkLevelUp()

    if self.foodsEaten < self.foodsPerLevel then
        return
    end

    self.foodsEaten = 0

    if self.level >= 2 then
        self:changeState("VictoryState")
        return
    end

    self:loadLevel(self.level + 1)
    self.snake:reset()
    self:generateFood()
    self:changeState("ServeState")

end


function Game:loseLife()

    self.lives = self.lives - 1

    if self.lives <= 0 then
        self:changeState("GameOverState")
    else
        self.snake:reset()
        self:generateFood()
        self:changeState("ServeState")
    end

end


function Game:changeState(newState)

    self.currentState = newState

end


function Game:getState()

    return self.currentState

end


function Game:isPlaying()

    return self.currentState == "PlayState"

end


-- Flechas mientras se juega (love.keyboard.isDown)
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


-- Teclas de estado (ENTER / SPACE / P)
function Game:keypressed(key)

    if self.currentState == "TitleState" and key == "return" then
        self:restart()

    elseif self.currentState == "ServeState" and key == "space" then
        self:changeState("PlayState")

    elseif self.currentState == "PlayState" and key == "p" then
        self:changeState("PauseState")

    elseif self.currentState == "PauseState" and key == "p" then
        self:changeState("PlayState")

    elseif self.currentState == "GameOverState" and key == "return" then
        self:restart()

    elseif self.currentState == "VictoryState" and key == "return" then
        self:initialize()

    end

end


return Game
