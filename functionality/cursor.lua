
CURSOR_IMAGES = {}
ANCHOR_COORDINATES = {}
local cursor_image_amount = 9
for i=1,cursor_image_amount do
    local CURSOR_MOD_PATH = SMODS.Mods["CTEH"].path .. "assets/2x/cursors/cursor" .. i .. ".png"
    local CURSOR_FIXED_PATH = assert(NFS.newFileData(CURSOR_MOD_PATH),('Failed to collect file data for Atlas %s'):format('cursor'))
    CURSOR_IMAGES[i] = love.graphics.newImage(CURSOR_FIXED_PATH, { mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling })
    -- manual checks
    if i == 1 or i == 8  then
        ANCHOR_COORDINATES[i] = {x=10,y=0}
    elseif i == 6 then
        ANCHOR_COORDINATES[i] = {x=18,y=0}
    elseif i == 7 or i == 9 then
        ANCHOR_COORDINATES[i] = {x=4,y=4}
    elseif i == 2 then
        ANCHOR_COORDINATES[i] = {x=2,y=6}
    elseif i == 3 then
        ANCHOR_COORDINATES[i] = {x=11,y=32}
    elseif i == 4 then
        ANCHOR_COORDINATES[i] = {x=9,y=0}
    elseif i == 5 then
        ANCHOR_COORDINATES[i] = {x=11,y=0}
    else
        ANCHOR_COORDINATES[i] = {x=0,y=0}
    end
end
CURSOR_HOLD_IMAGES = {}
local cursor_hold_image_amount = 8
for i=1,cursor_hold_image_amount do
    local CURSOR_MOD_PATH = SMODS.Mods["CTEH"].path .. "assets/2x/cursors/cursor_hold" .. i .. ".png"
    local CURSOR_FIXED_PATH = assert(NFS.newFileData(CURSOR_MOD_PATH),('Failed to collect file data for Atlas %s'):format('cursor'))
    CURSOR_HOLD_IMAGES[i] = love.graphics.newImage(CURSOR_FIXED_PATH, { mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling })
end

-- not local so the settings patch can access it. Could I instead make it local IN the patch? y not!
CURSOR = {
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() / 2,
    sensitivity = 1,
    default_sensitivity = 1,

    image_index = 1,
    image = CURSOR_IMAGES[1],
    ox = ANCHOR_COORDINATES[1].x,
    oy = ANCHOR_COORDINATES[1].y,
    has_hold_m1 = true,
    image_hold_index = 1,
    image_hold = CURSOR_HOLD_IMAGES[1],
    m1_index = 1,
    held = false,
}
local function keepCursorInBorder()
    if CURSOR.x < 0 then CURSOR.x = 0
    elseif CURSOR.x > love.graphics.getWidth() then CURSOR.x = love.graphics.getWidth()
    end
    if CURSOR.y < 0 then CURSOR.y = 0
    elseif CURSOR.y > love.graphics.getHeight() then CURSOR.y = love.graphics.getHeight()
    end
end

function G.FUNCS.set_m1_image(args)
    CURSOR.image = CURSOR_IMAGES[args.to_key] or CURSOR_IMAGES[1]
    CURSOR.ox = ANCHOR_COORDINATES[args.to_key] and ANCHOR_COORDINATES[args.to_key].x or ANCHOR_COORDINATES[1].x
    CURSOR.oy = ANCHOR_COORDINATES[args.to_key] and ANCHOR_COORDINATES[args.to_key].y or ANCHOR_COORDINATES[1].y
    CURSOR.image_index = args.to_key < cursor_image_amount and args.to_key or 1
end
function G.FUNCS.set_m1_hold_image(args)
    CURSOR.image_hold = CURSOR_HOLD_IMAGES[args.to_key] or CURSOR_HOLD_IMAGES[1]
    CURSOR.image_hold_index = args.to_key < cursor_hold_image_amount and args.to_key or 1
end

function setSensitivity(new_sens)
    CURSOR.sensitivity = new_sens
end
function resetSensitivity()
    setSensitivity(CURSOR.default_sensitivity)
end
function getCursorPosition()
    return CURSOR.x, CURSOR.y
end

------------------------------- LOVE FUNCTIONS
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

    if CURSOR.held == true and CURSOR.has_hold_m1 then
        love.graphics.draw(
            CURSOR.image_hold,
            CURSOR.x,
            CURSOR.y
        )
    else 
        love.graphics.draw(
            CURSOR.image,
            CURSOR.x - CURSOR.ox,
            CURSOR.y - CURSOR.oy
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