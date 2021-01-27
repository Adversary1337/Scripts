local gui = {
    checkbox = ui.new_checkbox("VISUALS", "Effects", "Hit effect"),
    slider = ui.new_slider("VISUALS", "Effects", "Hit effect", 3, 20, 5, true, "s", 0.1),
}


local function on_player_hurt(e)
    if ui.get(gui.checkbox) ~= true then
        return
    end

    local attacker = e.attacker
    local attacker_id = client.userid_to_entindex(attacker)
    local local_id = entity.get_local_player()

    if attacker_id == local_id then
        entity.set_prop(local_id, "m_flHealthShotBoostExpirationTime", globals.curtime() + (ui.get(gui.slider) * 0.1))
    end
end


client.set_event_callback("player_hurt", on_player_hurt)
