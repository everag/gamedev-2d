Piece = Class{}

function Piece:init(x, y, r, g, b)
    self.x = x
    self.y = y
    self.r = r
    self.g = g
    self.b = b
    self.dx = 0
    self.dy = 0
    self.ix = x
    self.iy = y
end

function Piece:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    
    if self.dx < 0 then
        self.x = math.max(self.x, 0)
    elseif self.dx > 0 then
        self.x = math.min(self.x, VIRTUAL_WIDTH - 1)
    end
    
    if self.dy < 0 then
        self.y = math.max(self.y, 0)
    elseif self.dy > 0 then
        self.y = math.min(self.y, VIRTUAL_HEIGHT - 1)
    end
    
    self.ix = math.floor(self.x + 0.5) or math.ceil(self.x - 0.5)
    self.iy = math.floor(self.y + 0.5) or math.ceil(self.y - 0.5)
end

function Piece:render()
    local r, g, b, a = love.graphics.getColor()
    print(self.r, self.g, self.b)
    love.graphics.setColor(self.r, self.g, self.b, 1)
    love.graphics.rectangle('fill', self.ix, self.iy, 1, 1)
    love.graphics.setColor(r, g, b, a)
end