Piece = Class{}

function Piece:init(x, y, r, g, b)
    self.x = x
    self.y = y
    self.r = r
    self.g = g
    self.b = b
    self.dx = 0 -- x axis velocity
    self.dy = 0 -- y axis velocity
    self.ax = x -- adjusted x
    self.ay = y -- adjusted y
end

function Piece:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    
    if self.dx < 0 then
        self.ax = math.max(self.x, 0)
    elseif self.dx > 0 then
        self.ax = math.min(self.x, VIRTUAL_WIDTH - 1)
    end
    
    if self.dy < 0 then
        self.ay = math.max(self.y, 0)
    elseif self.dy > 0 then
        self.ay = math.min(self.y, VIRTUAL_HEIGHT - 1)
    end
end

function Piece:render()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.r, self.g, self.b, 1)
    love.graphics.rectangle('fill', math.floor(self.ax), math.floor(self.ay), 1, 1)
    love.graphics.setColor(r, g, b, a)
end