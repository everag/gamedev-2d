Snake = Class{}

function Snake:init(x, y, r, g, b)
    self.head = Piece(x, y, r, g, b)
    self.dy = 0
    self.dx = 0
end

function Snake:update(dt)
    self.head.dx = self.dx
    self.head.dy = self.dy
    self.head:update(dt)
end

function Snake:render()
    self.head:render()
end