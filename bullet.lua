local Bullet = {};
Bullet.__index = Bullet;

function Bullet:New(x, y, speed, dir)
	local self  = setmetatable({}, Bullet)
	self.x      = x or 0
	self.y      = y or 0
	self.speed  = speed or 0
	self.dir    = dir or { x = 0, y = -1 }
	self.radius = 4
	return self
end

function Bullet:update(dt)
	self.x = self.x + self.dir.x * self.speed * dt
	self.y = self.y + self.dir.y * self.speed * dt
end

function Bullet:draw()
	love.graphics.circle("fill", self.x, self.y, self.radius)
end

return Bullet
