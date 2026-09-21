-- levels.lua
-- Datos de niveles (tabla Lua).
-- Nivel 1: solo bordes (sin paredes internas).
-- Nivel 2: bordes + pared pequeña en el medio.

local W = require("classes.Wall")
local SolidWall = W.SolidWall


local Levels = {}


function Levels.build(levelNumber, cellSize)

    local walls = {}
    local data = Levels.data[levelNumber]

    if not data then
        return walls
    end

    for _, w in ipairs(data.walls) do
        local x = w.col * cellSize
        local y = w.row * cellSize
        table.insert(walls, SolidWall:new(x, y, cellSize))
    end

    return walls

end


Levels.data = {

    -- Nivel 1: solo bordes
    [1] = {
        walls = {}
    },

    -- Nivel 2: pared pequeña horizontal en el medio
    [2] = {
        walls = {
            { col = 15, row = 14 },
            { col = 16, row = 14 },
            { col = 17, row = 14 },
            { col = 18, row = 14 },
            { col = 19, row = 14 },
            { col = 20, row = 14 },
            { col = 21, row = 14 },
            { col = 22, row = 14 },
            { col = 23, row = 14 },
            { col = 24, row = 14 },
        }
    }

}


return Levels
