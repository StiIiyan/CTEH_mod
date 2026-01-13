
local CURSOR_MOD_PATH = SMODS.Mods["CTEH"].path .. "assets/2x/cursor.png"
local CURSOR_FIXED_PATH = assert(NFS.newFileData(CURSOR_MOD_PATH),('Failed to collect file data for Atlas %s'):format('cursor'))

local CURSOR2_MOD_PATH = SMODS.Mods["CTEH"].path .. "assets/2x/cursor_hold.png"
local CURSOR2_FIXED_PATH = assert(NFS.newFileData(CURSOR2_MOD_PATH),('Failed to collect file data for Atlas %s'):format('cursor'))

local DEFAULT_SENSITIVITY = 1.0
local CURSOR = {
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() / 2,
    sensitivity = 1,

    image = love.graphics.newImage(CURSOR_FIXED_PATH, { mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling }),
    ox = 10,
    oy = 0,
    image_hold = love.graphics.newImage(CURSOR2_FIXED_PATH, { mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling }),
    ox2 = 10,
    oy2 = 0,
    held = false
}
local function keepCursorInBorder()
    if CURSOR.x < 0 then CURSOR.x = 0
    elseif CURSOR.x > love.graphics.getWidth() then CURSOR.x = love.graphics.getWidth()
    end
    if CURSOR.y < 0 then CURSOR.y = 0
    elseif CURSOR.y > love.graphics.getHeight() then CURSOR.y = love.graphics.getHeight()
    end
end

function setSensitivity(new_sens)
    CURSOR.sensitivity = new_sens
end
function resetSensitivity()
    setSensitivity(DEFAULT_SENSITIVITY)
end
function getCursorPosition()
    return CURSOR.x, CURSOR.y
end


local prev_load = love.load
function love.load()
    prev_load()

    love.mouse.setRelativeMode(true)
end

local prev_update = love.update
function love.update(dt)
    prev_update(dt)
    
    love.mouse.setVisible(false)
    love.mouse.setRelativeMode(true)
end

local prev_draw = love.draw
function love.draw()
    prev_draw()

    if CURSOR.held == false then
        love.graphics.draw(
            CURSOR.image,
            CURSOR.x - CURSOR.ox,
            CURSOR.y - CURSOR.oy
        )
    else 
        love.graphics.draw(
            CURSOR.image_hold,
            CURSOR.x - CURSOR.ox2,
            CURSOR.y - CURSOR.oy2
        )
    end
end


local prev_mousepressed = love.mousepressed
function love.mousepressed(x, y, button)
    local cx, cy = getCursorPosition()
    prev_mousepressed(cx, cy, button)
    if button == 1 then CURSOR.held = true end
end

local prev_mousereleased = love.mousereleased
function love.mousereleased(x, y, button)
    local cx, cy = getCursorPosition()
    prev_mousereleased(cx, cy,button)
    if button == 1 then CURSOR.held = false end
end

local prev_mousemoved = love.mousemoved
function love.mousemoved(x, y, dx, dy)
    CURSOR.x = CURSOR.x + dx * CURSOR.sensitivity
    CURSOR.y = CURSOR.y + dy * CURSOR.sensitivity
    keepCursorInBorder()

    prev_mousemoved(x, y, dx, dy)
end