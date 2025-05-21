local Tree = {};

Tree.__index = Tree;

function Tree:New(x, y, img, desiredW, desiredH)
	local self = setmetatable({}, Tree);
	self.x = x or 0;
	self.y = y or 0;
	self.img = img;
	self.scaleX = (desiredW or img:getWidth()) / img:getWidth();
	self.scaleY = (desiredH or img:getHeight()) / img:getHeight();
	return self;
end

function Tree:draw()
	love.graphics.draw(
		self.img,
		self.x,
		self.y,
		0,
		self.scaleX,
		self.scaleY
	);
end

function Tree:toTable()
	return {
		x = self.x,
		y = self.y,
		scaleX = self.scaleX,
		scaleY = self.scaleY,
	}
end

return Tree;
