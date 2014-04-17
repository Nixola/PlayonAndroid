local notes = {}
notes.sources = {}

local RATE = 22050

local args = {...}

local noteMin = args[3] or 1

local noteMax = args[4] or 92

local round = function(n) return math.floor(n+.5) end

local dec = function(x)
	return x - math.floor(x)
end

local sin = math.sin

local pi = math.pi

local down = math.floor

local up = math.ceil

local sqrt = math.sqrt

local abs = math.abs

functions = {}
functions.sine = function(s, v, a) return (a*sin(s/(RATE/v)*pi*2)) end
functions.saw = function(s, v, a) local n = 2*(s*v/RATE-math.floor(1/2+s*v/RATE))*a; return n end
--functions.square=function(s, v, a) local ssin = sin(s/(RATE/v)*pi*2); return ssin >0 and a or ssin<0 and -a or 0 end
--functions.triang = function(s, v, a) return 2*math.abs(functions.saw(s,v,a))-1 end
--functions.string = function(s,v,a) return (functions.triang(s, v*2, a)+functions.triang(s,v,a)+functions.saw(s,v,a))*a/3 end
functions.organ = function(s, v, a) return functions.sine(s, v/2, a/5)+functions.sine(s, v, a/5)+functions.sine(s, v*2, a/5)+functions.sine(s, v*4, a/5)+functions.sine(s, v*8, a/5) end
functions.sinebeat = function(s, v, a) 
	local attack = math.floor(0.002 * RATE);
	local decay = attack + math.floor(0.2 * RATE);
	if s <= attack then
		a = a*(s/attack)
	elseif s <= decay then
		a = (1-(s/decay))*a
	else
		a = 0
	end
	return functions.sine(s, v, a);
end
functions.organbeat = function(s,v,a)
	local attack = math.floor(0.002 * RATE)
	local decay = attack + math.floor(0.2 * RATE)
	if s <= attack then
		a = a * s / attack
	elseif s <= decay then a = (1-(s/decay))*a
	else return 0
	end
	return functions.organ(s,v,a)
end
functions.guitarbeat --[[continuous guitar?]] = function(s, v, a, t)
	local N = math.floor(RATE / v)
	if not t then
		t = {}
		for i = 1, N do
			t[i] = love.math.random()-0.5
		end
	end
	if s+1 <= N then
		return t[s+1], t
	end
	t[N+1] = (t[1]+t[2])*.498
	table.remove(t, 1)
	return t[1], t
end
	
	
if not functions[args[1]] then

	error("Wrong synth!")
	
end

local a = args[2]
notes.a4 = 440
notes.diff = (2^(1/12))
notes[49] = notes.a4
for i = 48, noteMin, -1 do
	notes[i] = notes[49]*(notes.diff^(i-49))
end

for i = 50, noteMax do
	notes[i] = notes[49]*(notes.diff^(i-49))
end

notes.soundDatas = {}
for i = noteMin, noteMax do
	local v = notes[i]
	local T = RATE/v
	local samples = math.floor(RATE/T)*T--*.202
	local t
	--local samples = RATE

	--local samples = T*15
	--print(samples)
	notes.soundDatas[i] = love.sound.newSoundData( samples, RATE, 16, 1)
	for s = 0, samples-1 do
		local sample
		sample, t = functions[args[1]](s, v, a, t)
		notes.soundDatas[i]:setSample(s, sample)
	end
end

notes.sources = {}
for i, v in pairs(notes.soundDatas) do
	notes.sources[i] = love.audio.newSource(v, 'static')
	if not args[1]:match("beat") then notes.sources[i]:setLooping(true) end
end

return notes
