local Setting = {}
Setting.__index = Setting
Setting.color = {}
Setting.color[true] = {0, 96, 0}
Setting.color[false]= {96, 0, 0}

Setting.new = function(x, y, r, text1, text2, value)

	local t = setmetatable({}, Setting)

	t.x = x
	t.y = y
	t.r = r
	t.text = {}
	t.text[true]  = tostring(text1) or ''
	t.text[false] = tostring(text2) or ''
	t.value = value or false

	return t

end


Setting.toggle = function(self)

	self.value = not self.value

end


Setting.draw = function(self)

	love.graphics.setColor(self.color[self.value])
	love.graphics.circle('fill', self.x, self.y, self.r, self.r*4)
	love.graphics.setColor(255,255,255)
	love.graphics.printf(self.text[self.value], self.x-self.r+4, self.y-fontSize/2, self.r*2-8, 'center')

end


return Setting
