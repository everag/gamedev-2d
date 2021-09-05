Snake = Class{}

function Snake:init(x, y, r, g, b)
    self.head = Piece(x, y, r, g, b)
    self.dy = 0
    self.dx = 0
    self.oob = false
end

function Snake:update(dt)
    self.head.dx = self.dx
    self.head.dy = self.dy
    self.head:update(dt)
end

function Snake:render()
    self.head:render()
end

function Snake:is_oob()
    if self.head.x < 0 or self.head.x > VIRTUAL_WIDTH or 
       self.head.y < 0 or self.head.y > VIRTUAL_HEIGHT then
        return true
    end
    return false
end