local menu = { 'VISUALS', 'Effects' }

local gui = {
    checkbox = ui.new_checkbox(menu[1], menu[2], 'Kill effect'),
    slider = ui.new_slider(menu[1], menu[2], 'Kill effect duration', 3, 20, 5, true, 's', 0.1),
}


client.set_event_callback('player_death', function(event)
    if ui.get(gui.checkbox) ~= true then
        return
    end

    local attacker = client.userid_to_entindex(event.attacker)
    local me = entity.get_local_player()

    if attacker == me then
        entity.set_prop(me, "m_flHealthShotBoostExpirationTime", globals.curtime() + (ui.get(gui.slider) * 0.1))
    end
end)
