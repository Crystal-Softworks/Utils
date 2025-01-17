--decompiled with swift using medal decompiler
--MEDAL GITHUB: https://github.com/shrimp-nz/medal
--Give them a star!

local v_u_1 = {
	31,
	0,
	31,
	30,
	31,
	30,
	31,
	31,
	30,
	31,
	30,
	31
}
local v_u_2 = {
	[0] = "Sunday",
	[1] = "Monday",
	[2] = "Tuesday",
	[3] = "Wednesday",
	[4] = "Thursday",
	[5] = "Friday",
	[6] = "Saturday"
}
local v_u_3 = {
	31536000,
	31536000,
	31622400,
	31536000
}
local v_u_4 = math.floor
local v_u_5 = math.ceil
return function(p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_3, (copy) v_u_1, (copy) v_u_5
	local v7 = {
		["EpochSeconds"] = p6,
		["Seconds"] = p6 % 60,
		["Minute"] = v_u_4(p6 % 3600 / 60)
	}
	local v8 = p6 % 86400 / 3600
	v7.MHour = v_u_4(v8)
	local v9 = v7.MHour
	v7.Hour = v9 % 12 == 0 and 12 or (v9 % 12 or 12)
	v7.AMOrPM = v9 < 12 and "AM" or "PM"
	v7.DayName = v_u_2[(v_u_4(p6 / 86400) + 4) % 7]
	local v10 = p6 % 126230400
	local v11 = 0
	for v12 = 1, 4 do
		local v13 = v_u_3[v12]
		if v13 > v10 then
			break
		end
		v10 = v10 - v13
		p6 = p6 - v13
		v11 = v11 + 1
	end
	v7.Year = v11 + v_u_4(p6 / 126230400) * 4 + 1970
	local v14 = p6 % 126230400
	v_u_1[2] = v7.Year % 4 == 0 and 29 or 28
	v7.Month = 1
	for v15 = 1, 12 do
		if v_u_1[v15] * 86400 >= v14 then
			v7.Month = v15
			break
		end
		v14 = v14 - v_u_1[v15] * 86400
	end
	v7.Day = v_u_5(v14 / 86400)
	if v8 == 0 then
		v7.MHour = 24
		if v7.MHour >= 24 then
			v7.MHour = 0
			v7.Day = v7.Day + 1
		end
		if v_u_1[v7.Month] <= v7.Day then
			v7.Day = 1
			v7.Month = v7.Month + 1
		end
		if v7.Month >= 12 then
			v7.Month = 1
			v7.Year = v7.Year + 1
		end
	end
	return v7
end
