local touches = {}

local round = function(x)
	return math.floor(x+.5)
end

if not love.touch then
    local lg, lm = love.graphics, love.mouse
    love.touch = {}
	assert(love.mouse, "=/")
	love.mousepressed = function(x, y, b)
	    if b == 'l' then
		    x = x / lg.getWidth();
			y = y / lg.getHeight();
			touches[1] = {
			    x = x;
				y = y;
				oldX = x;
				oldY = y;
				pressure = 1;
				oldPressure = 1;
				id = 1;
		    }
			love.touch.pressed(1, x, y, 1)
		end
	end

	love.mousereleased = function(x, y, b)
	    if b == 'l' then
		    touches[1] = nil
			love.touch.released(1, x/lg.getWidth(), y/lg.getHeight(), 1)
		end
	end

	love.touch.update = function(dt)
	    if touches[1] and lm.isDown 'l' then
		    local t = touches[1]
			t.oldX = t.x
			t.oldY = t.y
			t.x = lm.getX()/lg.getWidth()
			t.y = lm.getY()/lg.getHeight()
			if not (t.x == t.oldX and t.y == t.oldY) then
			    love.touch.moved(1, t.x, t.y, 1)
			end
		end
	end
end
love.touch.update = love.touch.update or function() end

love.touchpressed = function(id, x, y, pressure)

	local t = {}
	
	t.x = x
	t.y = y
	t.oldX = t.x
	t.oldY = t.y
	t.pressure = pressure
	t.oldPressure = pressure
	t.id = id

	touches[id] = t

	if love.touch.pressed then

		love.touch.pressed(id, x, y, pressure)

	end

end


love.touchreleased = function(id, x, y, pressure)

	touches[id] = nil

	if love.touch.released then
	
		love.touch.released(id, x, y, pressure)

	end

end


love.touchmoved = function(id, x, y, pressure)

	local t = touches[id]

	t.oldX = t.x
	t.x = x

	t.oldY = t.y
	t.y = y

	t.oldPressure = t.pressure
	t.pressure = pressure

	if love.touch.moved then
	
		love.touch.moved(id, x, y, pressure)

	end

end


love.touch.touches = touches
