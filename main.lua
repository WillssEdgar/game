local json    = require 'json'
local Player  = require 'player'
local Tree    = require 'tree'
local Bullet  = require 'bullet'
local bullets = {}

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	local img                        = love.graphics.newImage('assets/player.png')
	player                           = Player:New(
		100,
		100,
		200,
		img,
		48,
		48
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

	for i = #bullets, 1, -1 do
		local b = bullets[i]
		b:update(dt)
		if b.x < 0 or b.x > love.graphics.getWidth()
				or b.y < 0 or b.y > love.graphics.getHeight() then
			table.remove(bullets, i)
		end
	end
end

function love.draw()
	for _, tree in ipairs(trees) do
		tree:draw();
	end

	for _, b in ipairs(bullets) do
		b:draw()
	end

	player:draw()
end

function love.keypressed(key)
	if key == 'space' then
		local b = player:shoot()
		if b then
			table.insert(bullets, b)
		end
	elseif key == 'q' then
		love.event.quit()
	end
end
