local Button = {}
Button.color = {96, 96, 96}
setmetatable(Button, Button)
local interval = 60/120

pl = function(i, beat)

	if not beat then

		sources[i]:play()

	else

		sources[i]:clone():play()

	end

end

Button.new = function(self, x, y, r, text, i)

    local t = {x = x, y = y, r = r, text = text, func = function() pl(i, settings.beat.value) end, timer = 0, cl = function() sources[i]:stop() end, i = i}

	return setmetatable(t, self)

end

Button.__call = Button.new
Button.__index = Button


Button.update = function(self, dt)
	
	--self.timer = self.timer + dt
	
	self.color = {160, 160, 160};

	--if self.timer > interval then

	--	self.timer = self.timer - interval
	self.func()

	--end
end


Button.clear = function(self)

	self.timer = 0;
	self.color = nil;
	self.cl()

end


Button.draw = function(self)
	love.graphics.setColor(self.color)
	love.graphics.circle('fill', self.x, self.y, self.r, self.r)
	love.graphics.setColor(255,255,255)
	love.graphics.printf(self.text, self.x-self.r+4, self.y-fontSize/2, self.r*2-8, 'center')
end


return Button;
