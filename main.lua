local json   = require 'json'
local Player = require 'player'
local Tree   = require 'tree'

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	local img                        = love.graphics.newImage('assets/player.png')
	player                           = Player:New(
		100, -- x
		100, -- y
		200, -- speed
		img, -- image
		48, -- desired draw width
		48 -- desired draw height
	)

	treeImage                        = love.graphics.newImage('assets/tree.png')
	local desiredTreeW, desiredTreeH = 32, 32
	treeScaleX                       = desiredTreeW / treeImage:getWidth()
	treeScaleY                       = desiredTreeH / treeImage:getHeight()

	trees                            = {}
	for i = 1, 15 do
		x = love.math.random(
			0,
			love.graphics.getWidth() - treeImage:getWidth() * treeScaleX
		);
		y = love.math.random(
			0,
			love.graphics.getHeight() - treeImage:getHeight() * treeScaleY
		);
		local t = Tree:New(x, y, treeImage, desiredTreeW, desiredTreeH)
		table.insert(trees, t)
	end
end

function love.update(dt)
	player:update(dt)
end

function love.draw()
	for _, tree in ipairs(trees) do
		tree:draw();
	end

	-- local serialized = json.encode(trees)
	-- love.graphics.print("trees: " .. serialized, 10, 10)

	-- draw the player
	player:draw()
end

function love.keypressed(key)
	if key == 'q' then love.event.quit() end
end
