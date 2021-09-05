push = require 'libs/push'
Class = require 'libs/class'

require 'Piece'
require 'Snake'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- scaled down to X% of the real window size
-- TODO: Not working properly with non multiples of 10
VIRTUAL_PROPORTION = 40
VIRTUAL_WIDTH = WINDOW_WIDTH / VIRTUAL_PROPORTION
VIRTUAL_HEIGHT = WINDOW_HEIGHT / VIRTUAL_PROPORTION

SPEED = 10

INITIAL_SNAKE_SIZE = 3

local curr_piece
local direction
local game_state

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Snake by everag')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    math.randomseed(os.time())
    
    local r, g, b = gen_rgb()
    local x, y = gen_random_coords()
    curr_piece = Piece(x, y, r, g, b)

    r, g, b = gen_rgb()
    snake = Snake(10, 10, r, g, b)

    game_state = 'start'
    direction = 'E'
end

function love.update(dt)
    if direction == 'E' then
        snake.dx = SPEED
        snake.dy = 0
    elseif direction == 'S' then
        snake.dx = 0
        snake.dy = SPEED
    elseif direction == 'W' then
        snake.dx = -SPEED
        snake.dy = 0
    elseif direction == 'N' then
        snake.dx = 0
        snake.dy = -SPEED
    end

    if game_state == 'play' then
        snake:update(dt)
    end

    if snake:is_oob() then
        game_state = 'game_over'
    end
end

function love.draw()
    push:start()
    
    love.graphics.clear(134/255, 81/255, 156/255, 255/255)
    love.window.setTitle(string.format("Snake by everag [%d FPS / %s]", love.timer.getFPS(), game_state))
    
    curr_piece:render()
    snake:render()

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if game_state == 'start' or game_state == 'pause' then
            game_state = 'play'
        elseif game_state == 'play' then
            game_state = 'pause'
        end
    end
    
    if key == 'down' or key == 's' then
        if direction == 'E' or direction == 'W' then
            direction = 'S'
        end
    elseif key == 'up' or key == 'w' then
        if direction == 'E' or direction == 'W' then
            direction = 'N'
        end
    elseif key == 'right' or key == 'd' then
        if direction == 'N' or direction == 'S' then
            direction = 'E'
        end
    elseif key == 'left' or key == 'a' then
        if direction == 'N' or direction == 'S' then
            direction = 'W'
        end
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function gen_random_coords()
    return 
        math.random(0, VIRTUAL_WIDTH - 1),
        math.random(0, VIRTUAL_HEIGHT - 1)
end

function gen_rgb()
    return 
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255)
end