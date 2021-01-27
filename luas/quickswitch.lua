local csgo_weapons = require 'gamesense/csgo_weapons'

local qkscope = ui.new_checkbox('MISC', 'Miscellaneous', 'Quick Switch')
local qkscopekey = ui.new_hotkey('MISC', 'Miscellaneous', 'Quick Switch Hotkey')
local quickswitch = ui.new_multiselect('MISC', 'Miscellaneous', 'Quick Switch', 'AWP', 'Scout', 'Deagle')
local select = {'AWP', 'Scout', 'Deagle'}
local quickswitchdelayawp = ui.new_slider('MISC', 'Miscellaneous', 'Quick Switch Delay AWP', 1, 200)
local quickswitchdelayssg = ui.new_slider('MISC', 'Miscellaneous', 'Quick Switch Delay SSG 08', 1, 200)
local quickswitchdelaydeagle = ui.new_slider('MISC', 'Miscellaneous', 'Quick Switch Delay Deagle', 1, 200)

local contains = function(table, val)
	if #table > 0 then
		for i=1, #table do
			if table[i] == val then
				return true
			end
		end
	end

	return false
end

client.set_event_callback('paint_ui', function()
	local selection = ui.get(quickswitch)
	local state = ui.get(qkscope)

	ui.set_visible(quickswitch, state)
	ui.set_visible(qkscopekey, state)
	ui.set_visible(quickswitchdelayawp, contains(selection, select[1]) and state)
	ui.set_visible(quickswitchdelayssg, contains(selection, select[2]) and state)
	ui.set_visible(quickswitchdelaydeagle, contains(selection, select[3]) and state)
end)

client.set_event_callback('paint', function()
	local selection = ui.get(quickswitch)
	local me = entity.get_local_player()
	local weapon_ent = entity.get_player_weapon(me)
	local weapon_idx = entity.get_prop(weapon_ent, 'm_iItemDefinitionIndex')
	weapon_idx = bit.band(weapon_idx, 0xFFFF)
	local weapon = csgo_weapons[weapon_idx]

	if me == nil then 
		return
	end

	if weapon_ent == nil then
		return
	end

	if weapon_idx == nil then
		return
	end

	if weapon == nil then
		return
	end
end)

client.set_event_callback('weapon_fire', function(event)
    local me = entity.get_local_player()
	local local_entindex = client.userid_to_entindex(event.userid)
	local weapon_ent = entity.get_player_weapon(me)
	local weapon_idx = entity.get_prop(weapon_ent, 'm_iItemDefinitionIndex')
	weapon_idx = bit.band(weapon_idx, 0xFFFF)
	local weapon = csgo_weapons[weapon_idx]
	
	if event.userid == nil then
        return
    end
	
	if me == nil then
		return
	end

	if weapon_ent == nil then
		return
	end

	if weapon_idx == nil then 
		return
	end

	if weapon == nil then
		return
	end
	
	local selection = ui.get(quickswitch)
	local delayawp = ui.get(quickswitchdelayawp)
	local delayssg = ui.get(quickswitchdelayssg)
	local delaydeagle = ui.get(quickswitchdelaydeagle)
	
	
	if weapon.name == 'AWP' then
		if local_entindex == me then
			if ui.get(qkscope) then
				if ui.get(qkscopekey) then
					if contains(selection, select[1]) then
						client.delay_call(delayawp / 1000, client.exec, 'use weapon_knife')
						client.delay_call(delayawp / 1000 * 2, client.exec, 'use weapon_awp')
					end
				end
			end
		end
	end
	
	if weapon.name == 'SSG 08' then
		if local_entindex == me then
			if ui.get(qkscope) then
				if ui.get(qkscopekey) then
					if contains(selection, select[2]) then
						client.delay_call(delayssg / 1000, client.exec, 'use weapon_knife')
						client.delay_call(delayssg / 1000 * 2, client.exec, 'use weapon_SSG08')
					end
				end
			end
		end
	end
	
	if weapon.name == 'Desert Eagle' then
		if local_entindex == me then
			if ui.get(qkscope) then
				if ui.get(qkscopekey) then
					if contains(selection, select[3]) then
						client.delay_call(delaydeagle / 1000, client.exec, 'use weapon_knife')
						client.delay_call(delaydeagle / 1000 * 2, client.exec, 'use weapon_deagle')
					end
				end
			end
		end
	end
end)