Paddle = Class{}

function Paddle:init(x, y, width, height, r, g, b)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
    self.dx = 0
    self.r = r
    self.g = g
    self.b = b
    self.id = string.format( "%x%x%x", r, g, b)
end

function Paddle:update(dt)
    self:calculateVerticalMovement(dt)
    self:calculateHorizontalMovement(dt)
    
    -- calculates, or not, the overflow paddle
    local overflow_y = self.y + self.height - VIRTUAL_HEIGHT
    if overflow_y > 0 then
        self.overflow = Paddle(self.x, 0, self.width, overflow_y, self.r, self.g, self.b)
    else
        self.overflow = nil
    end
end

function Paddle:calculateVerticalMovement(dt)
    local new_y = self.y + self.dy * dt
    if self.dy < 0 then
        if new_y < 0 then
            diff = math.abs(new_y)
            if diff >= self.height then
                new_y = VIRTUAL_HEIGHT - diff
            end
        end
    else
        if new_y > VIRTUAL_HEIGHT - self.height then
            diff = math.abs(new_y - VIRTUAL_HEIGHT + self.height)
            if diff >= self.height then
                new_y = diff - self.height
            end
        end
    end
    if new_y < 0 then
        new_y = VIRTUAL_HEIGHT - new_y
    end
    self.y = new_y
end

function Paddle:calculateHorizontalMovement(dt)
    local new_x = self.x + self.dx * dt
    if self.x < VIRTUAL_WIDTH / 2 then
        -- left paddle
        if self.dx < 0 then
            new_x = math.max(new_x, 10)
        else
            new_x = math.min(new_x, VIRTUAL_WIDTH / 2 - 5 - 20)
        end
    else
        -- right paddle
        if self.dx < 0 then
            new_x = math.max(new_x, VIRTUAL_WIDTH / 2 + 20)
        else
            new_x = math.min(new_x, VIRTUAL_WIDTH - 10 - 5)
        end
    end
    self.x = new_x
end

function Paddle:render()
    -- EVERAG: Paddles have different colors
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.r, self.g, self.b, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    if self.overflow then
        self.overflow:render()
    end
    love.graphics.setColor(r, g, b, a)
end