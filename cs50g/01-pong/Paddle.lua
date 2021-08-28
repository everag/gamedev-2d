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
end

function Paddle:update(dt)
    new_y = self.y + self.dy * dt
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
    self.y = new_y
end

function Paddle:render()
    -- EVERAG: Paddles have different colors
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.r, self.g, self.b, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    if self.y < 0 then
        love.graphics.rectangle('fill', self.x, self.y + VIRTUAL_HEIGHT, self.width, self.height)
    elseif self.y > VIRTUAL_HEIGHT - self.height then
        diff = self.y - VIRTUAL_HEIGHT
        love.graphics.rectangle('fill', self.x, diff, self.width, self.height)
    end
    love.graphics.setColor(r, g, b, a)
end