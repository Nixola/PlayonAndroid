require 'sounddata-ffi'

require 'touch'

if not love.window.getPixelScale then

	love.window.getPixelScale = function()

		return 1

	end

end

Setting = require 'setting';

local notes = love.filesystem.load "notes.lua"

Button = require 'button';
--[[
instr = {
	[false] = love.filesystem.load('notes.lua')('organbeat', 1/3).sources,
	[true]  = love.filesystem.load('notes.lua')('sinebeat', 1/3).sources}
sine = false
sources = instr[sine]--]]
instr = {
	[false] = {
		[true] = notes("organbeat", 1/3, 28, 68),
		[false] = notes("organ", 1/3, 28, 68)},
	[true] = {
		[true] = notes("guitarbeat", 1/3, 28, 68),
		[false] = notes("sine", 1/3, 28, 68)}
}
sine = false
beat = true
--sources = love.filesystem.load("notes.lua")("organbeat", 1/3).sources
sources = instr[sine][beat].sources
timer = 0;
interval = 1/16;
r = 32*love.window.getPixelScale()
fontSize = 16*love.window.getPixelScale()
love.graphics.setNewFont(fontSize)

local scrHeight = love.graphics.getHeight()

love.keypressed = function(key)

    if key == "escape" then

		love.event.quit();

	--elseif key == "menu" then

		--beat = not beat
		--love.audio.stop()
		--sources = instr[sine][beat].sources

	end

end

buttons = {}
buttons[1] = Button(r*1, scrHeight-r, r, "C2", 28)
buttons[2] = Button(r*2, scrHeight-r-(3^.5)*r, r, "C2#", 29)
buttons[3] = Button(r*3, scrHeight-r, r, "D2", 30)
buttons[4] = Button(r*4, scrHeight-r-(3^.5)*r, r, "D2#", 31)
buttons[5] = Button(r*5, scrHeight-r, r, "E2", 32)
buttons[6] = Button(r*7, scrHeight-r, r, "F2", 33)
buttons[7] = Button(r*8, scrHeight-r-(3^.5)*r, r, "F2#", 34)
buttons[8] = Button(r*9, scrHeight-r, r, "G2", 35)
buttons[9] = Button(r*10,scrHeight-r-(3^.5)*r, r, "G2#", 36)
buttons[10]= Button(r*11,scrHeight-r, r, "A3", 37)
buttons[11]= Button(r*12,scrHeight-r-(3^.5)*r, r, "A3#", 38)
buttons[12]= Button(r*13,scrHeight-r, r, "B3", 39)
buttons[13]= Button(r*15,scrHeight-r, r, "C3", 40)
buttons[14]= Button(r*16,scrHeight-r-(3^.5)*r, r, "C3#", 41)
buttons[15]= Button(r*17,scrHeight-r, r, "D3", 42)
buttons[16]= Button(r*18,scrHeight-r-(3^.5)*r, r, "D3#", 43)
buttons[17]= Button(r*19,scrHeight-r, r, "E3", 44)


buttons[18] = Button(r*1, scrHeight-r-(3^.5)*r*2, r, "C3", 40)
buttons[19] = Button(r*2, scrHeight-r-(3^.5)*r*3, r, "C3#", 41)
buttons[20] = Button(r*3, scrHeight-r-(3^.5)*r*2, r, "D3", 42)
buttons[21] = Button(r*4, scrHeight-r-(3^.5)*r*3, r, "D3#", 43)
buttons[22] = Button(r*5, scrHeight-r-(3^.5)*r*2, r, "E3", 44)
buttons[23] = Button(r*7, scrHeight-r-(3^.5)*r*2, r, "F3", 45)
buttons[24] = Button(r*8, scrHeight-r-(3^.5)*r*3, r, "F3#", 46)
buttons[25] = Button(r*9, scrHeight-r-(3^.5)*r*2, r, "G3", 47)
buttons[26] = Button(r*10,scrHeight-r-(3^.5)*r*3, r, "G3#", 48)
buttons[27] = Button(r*11,scrHeight-r-(3^.5)*r*2, r, "A4", 49)
buttons[28] = Button(r*12,scrHeight-r-(3^.5)*r*3, r, "A4#", 50)
buttons[29] = Button(r*13,scrHeight-r-(3^.5)*r*2, r, "B4", 51)
buttons[30] = Button(r*15,scrHeight-r-(3^.5)*r*2, r, "C4", 52)
buttons[31] = Button(r*16,scrHeight-r-(3^.5)*r*3, r, "C4#", 53)
buttons[32] = Button(r*17,scrHeight-r-(3^.5)*r*2, r, "D4", 54)
buttons[33] = Button(r*18,scrHeight-r-(3^.5)*r*3, r, "D4#", 55)
buttons[34] = Button(r*19,scrHeight-r-(3^.5)*r*2, r, "E4", 56)

buttons[35] = Button(r*1, scrHeight-r-(3^.5)*r*4, r, "C4", 52)
buttons[36] = Button(r*2, scrHeight-r-(3^.5)*r*5, r, "C4#", 53)
buttons[37] = Button(r*3, scrHeight-r-(3^.5)*r*4, r, "D4", 54)
buttons[38] = Button(r*4, scrHeight-r-(3^.5)*r*5, r, "D4#", 55)
buttons[39] = Button(r*5, scrHeight-r-(3^.5)*r*4, r, "E4", 56)
buttons[40] = Button(r*7, scrHeight-r-(3^.5)*r*4, r, "F4", 57)
buttons[41] = Button(r*8, scrHeight-r-(3^.5)*r*5, r, "F4#", 58)
buttons[42] = Button(r*9, scrHeight-r-(3^.5)*r*4, r, "G4", 59)
buttons[43] = Button(r*10,scrHeight-r-(3^.5)*r*5, r, "G4#", 60)
buttons[44] = Button(r*11,scrHeight-r-(3^.5)*r*4, r, "A5", 61)
buttons[45] = Button(r*12,scrHeight-r-(3^.5)*r*5, r, "A5#", 62)
buttons[46] = Button(r*13,scrHeight-r-(3^.5)*r*4, r, "B5", 63)
buttons[47] = Button(r*15,scrHeight-r-(3^.5)*r*4, r, "C5", 64)
buttons[48] = Button(r*16,scrHeight-r-(3^.5)*r*5, r, "C5#", 65)
buttons[49] = Button(r*17,scrHeight-r-(3^.5)*r*4, r, "D5", 66)
buttons[50] = Button(r*18,scrHeight-r-(3^.5)*r*5, r, "D5#", 67)
buttons[51] = Button(r*19,scrHeight-r-(3^.5)*r*4, r, "E5", 68)

updated = {}

notUpdated = {}


settings = {}
settings.sine = Setting.new(r*6, scrHeight-r-(3^.5)*r, r-4*love.window.getPixelScale(), "Sine", "Organ", false)
settings.beat = Setting.new(r*6, scrHeight-r-(3^.5)*r*3, r-4*love.window.getPixelScale(), "Beat", "Continue", true)



for i, v in ipairs(buttons) do

	notUpdated[i] = v

end

table.move = function(t1, t2, i)

	table.insert(t2, t1[i])
	table.remove(t1, i)
end

love.update = function(dt)

	if love.touch.update then

		love.touch.update(dt)

	end

	timer = timer + dt
	if settings.beat.value then return end
	played = {}
	--local play = false
	--if timer >= interval then
	timer = timer % interval
	--play = true
	collectgarbage("collect")
	--end

	for _, touch in pairs(love.touch.touches) do

		local x, y = touch.x, touch.y
		
		x = x * love.graphics.getWidth()
		y = y * love.graphics.getHeight()

		for i, v in ipairs(notUpdated) do

			if (v.x-x)^2+(v.y-y)^2 < v.r^2 then

			    v:update(dt)
			    played[v.i] = true
			    table.move(notUpdated, updated, i)
			end
		end
	end

	for i, v in ipairs(notUpdated) do

		if not played[v.i] then

			v:clear()

		end

		table.move(notUpdated, updated, i)

	end

	notUpdated, updated = updated, notUpdated
end


love.draw = function()

	for i, v in ipairs(buttons) do

		v:draw()
	
	end

	for i, v in pairs(settings) do

		v:draw()

	end

	--love.graphics.rectangle("fill", 0, 16, timer / interval * love.graphics.getWidth(), 16)

	--love.graphics.print(love.timer.getFPS(), 0, 0)

end


love.touch.pressed = function(id, x, y, pressure)

	x = x * love.graphics.getWidth()
	y = y * love.graphics.getHeight()

	for i, v in pairs(settings) do

		if (x-v.x)^2+(y-v.y)^2 < v.r^2 then

			v:toggle()
			sources = instr[settings.sine.value][settings.beat.value].sources

		end

	end

	if not settings.beat.value then return end

	for i, v in ipairs(buttons) do

		if (x-v.x)*(x-v.x)+(y-v.y)*(y-v.y) < v.r^2 then

			v:update(0)

		else

			v:clear()

		end
	
	end

end


love.touch.moved = function(id, x, y, pressure)

	if not settings.beat.value then return end

	local touch = love.touch.touches[id]

	local oldNear, newNear

	x, y = touch.x*love.graphics.getWidth(), touch.y*love.graphics.getHeight()
	local ox, oy = touch.oldX*love.graphics.getWidth(), touch.oldY*love.graphics.getHeight()

	for i, v in ipairs(buttons) do

		if (x-v.x)*(x-v.x)+(y-v.y)*(y-v.y) < v.r*v.r then

			newNear = v

		end

		if (ox-v.x)*(ox-v.x)+(oy-v.y)*(oy-v.y) < v.r*v.r then

			oldNear = v

		end

	end

	if newNear ~= oldNear then

		if newNear then
			newNear:update(0)
		end
		if oldNear then
			oldNear:clear()
		end

	end

end

love.touch.released = function(id, x, y, pressure)

	if not settings.beat.value then return end

	x = x * love.graphics.getWidth()

	y = y * love.graphics.getHeight()

	for i, v in ipairs(buttons) do

		if (x-v.x)*(x-v.x)+(y-v.y)*(y-v.y) < v.r^2 then

			v:clear()

		end
	
	end

end
