local Player = {};

Player.__index = Player;

function Player:New(x, y, speed, img, desiredW, desiredH)
	local self  = setmetatable({}, Player)
	self.x      = x or 0
	self.y      = y or 0
	self.speed  = speed or 200
	self.img    = img
	self.scaleX = (desiredW or img:getWidth()) / img:getWidth()
	self.scaleY = (desiredH or img:getHeight()) / img:getHeight()
	return self
end

function Player:update(dt)
	if love.keyboard.isDown('k') then self.y = self.y - self.speed * dt end
	if love.keyboard.isDown('j') then self.y = self.y + self.speed * dt end
	if love.keyboard.isDown('h') then self.x = self.x - self.speed * dt end
	if love.keyboard.isDown('l') then self.x = self.x + self.speed * dt end

	-- clamp to screen
	local pw = self.img:getWidth() * self.scaleX
	local ph = self.img:getHeight() * self.scaleY
	self.x = math.max(0, math.min(self.x, love.graphics.getWidth() - pw))
	self.y = math.max(0, math.min(self.y, love.graphics.getHeight() - ph))
end

function Player:draw()
	love.graphics.draw(
		self.img,
		self.x, self.y,
		0,
		self.scaleX,
		self.scaleY
	)
end

return Player;
