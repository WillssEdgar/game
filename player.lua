local Player    = {};
local json      = require('json')

local Bullet    = require 'bullet'

Player.__index  = Player;
Player.fireRate = 0.2

function Player:New(x, y, speed, img, desiredW, desiredH)
	local self              = setmetatable({}, Player)
	self.x                  = x or 0
	self.y                  = y or 0
	self.speed              = speed or 200
	self.img                = img
	self.scaleX             = (desiredW or img:getWidth()) / img:getWidth()
	self.scaleY             = (desiredH or img:getHeight()) / img:getHeight()
	self._timeSinceLastShot = 0
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
	self._timeSinceLastShot = self._timeSinceLastShot + dt
end

function Player:shoot()
	if self._timeSinceLastShot < self.fireRate then
		return nil
	end
	self._timeSinceLastShot = 0

	local w, h = self.img:getWidth() * self.scaleX, self.img:getHeight() * self.scaleY
	local bx, by = self.x + w / 2, self.y

	mouseX, mouseY = love.mouse.getPosition();

	local dx = mouseX - bx
	local dy = mouseY - by
	local length = math.sqrt(dx * dx + dy * dy)

	local dir = { x = dx / length, y = dy / length }
	return Bullet:New(bx, by, 500, dir)
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
