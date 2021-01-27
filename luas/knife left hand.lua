local knife_lefthand = ui.new_checkbox('VISUALS', 'Effects', 'Knife left hand')

client.set_event_callback('run_command', function()
  if ui.get(knife_lefthand) then
		local me = entity.get_local_player()

		if me ~= nil then
			local weapon = entity.get_player_weapon(me)

			if entity.get_classname(weapon) == "CKnife" then
				client.exec('cl_righthand 0')
			else
				client.exec('cl_righthand 1')
			end
		end
	end
end)
