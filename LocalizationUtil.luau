--decompiled with swift using medal decompiler
--MEDAL GITHUB: https://github.com/shrimp-nz/medal
--Give them a star!

wait()
local v1 = {}
local v_u_2 = game:GetService("LocalizationService")
local v_u_3 = game:GetService("RunService"):IsStudio()
local v_u_4 = game:GetService("Players").LocalPlayer
local v_u_5 = "en"
local v_u_6 = nil
local v_u_7 = nil
local v_u_8 = nil
local v_u_9 = nil
(function()
	-- upvalues: (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (copy) v_u_2, (copy) v_u_4, (ref) v_u_9, (ref) v_u_5
	if not (v_u_6 or v_u_7) then
		print("Get translators")
		v_u_8 = pcall(function()
			-- upvalues: (ref) v_u_6, (ref) v_u_2, (ref) v_u_4
			v_u_6 = v_u_2:GetTranslatorForPlayerAsync(v_u_4)
		end)
		print("Got translator")
		v_u_9 = pcall(function()
			-- upvalues: (ref) v_u_7, (ref) v_u_2, (ref) v_u_5
			v_u_7 = v_u_2:GetTranslatorForLocaleAsync(v_u_5)
		end)
		print("Got fallback translator")
	end
end)()
function v1.setSourceLanguage(p_u_10)
	-- upvalues: (ref) v_u_5, (ref) v_u_9, (ref) v_u_7, (copy) v_u_2
	if v_u_5 ~= p_u_10 then
		v_u_9 = pcall(function()
			-- upvalues: (ref) v_u_7, (ref) v_u_2, (ref) v_u_5, (copy) p_u_10
			v_u_7 = v_u_2:GetTranslatorForLocaleAsync(v_u_5)
			v_u_5 = p_u_10
			return true
		end)
	end
	return false
end
function v1.Translate(_, ...)
	-- upvalues: (copy) v_u_3, (ref) v_u_6, (copy) v_u_4, (copy) v_u_2, (ref) v_u_9, (ref) v_u_7
	local v_u_11 = { ... }
	local v_u_12 = v_u_6
	if not v_u_4 then
		local v_u_13 = table.remove(v_u_11, 1)
		pcall(function()
			-- upvalues: (ref) v_u_12, (ref) v_u_2, (copy) v_u_13
			v_u_12 = v_u_2:GetTranslatorForPlayerAsync(v_u_13)
		end)
	end
	local v_u_14 = game
	local v15 = v_u_11[1]
	if typeof(v15) == "Instance" then
		v_u_14 = table.remove(v_u_11, 1)
	end
	local v18, v19 = pcall(function()
		-- upvalues: (ref) v_u_12, (ref) v_u_14, (copy) v_u_11, (ref) v_u_9, (ref) v_u_7
		if v_u_12 then
			local v16 = v_u_11
			return v_u_12:Translate(v_u_14, unpack(v16))
		end
		if v_u_9 then
			local v17 = v_u_11
			return v_u_7:Translate(v_u_14, unpack(v17))
		end
	end)
	if v18 then
		if v19 then
			return v19
		end
	else
		error("Could not translate: " .. table.concat(v_u_11, ", ") .. ": " .. tostring(v19))
	end
	return false
end
function v1.TranslateByKey(_, ...)
	-- upvalues: (copy) v_u_3, (ref) v_u_6, (copy) v_u_4, (copy) v_u_2, (ref) v_u_9, (ref) v_u_7
	local v_u_20 = { ... }
	local v_u_21 = v_u_6
	if not v_u_4 then
		local v_u_22 = table.remove(v_u_20, 1)
		pcall(function()
			-- upvalues: (ref) v_u_21, (ref) v_u_2, (copy) v_u_22
			v_u_21 = v_u_2:GetTranslatorForPlayerAsync(v_u_22)
		end)
	end
	local v_u_23 = ""
	local v24, v25
	if v_u_21 then
		v24, v25 = pcall(function()
			-- upvalues: (ref) v_u_23, (ref) v_u_21, (copy) v_u_20
			local v26 = v_u_20
			v_u_23 = v_u_21:FormatByKey(unpack(v26))
		end)
	else
		v24 = false
		v25 = nil
	end
	if v_u_9 and not v24 then
		v24, v25 = pcall(function()
			-- upvalues: (ref) v_u_23, (ref) v_u_7, (copy) v_u_20
			local v27 = v_u_20
			v_u_23 = v_u_7:FormatByKey(unpack(v27))
		end)
	end
	if v24 then
		return v_u_23
	end
	warn("Translation failed: ", ..., v25)
	return false
end
return v1
