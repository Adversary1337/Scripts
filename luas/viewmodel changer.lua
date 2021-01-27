local xO = 0
local yO = 0
local zO = 0
local fO = 0
local function cache()
    xO = client.get_cvar("viewmodel_offset_x")
    yO = client.get_cvar("viewmodel_offset_y")
    zO = client.get_cvar("viewmodel_offset_z")
  --fO = client.get_cvar("viewmodel_fov")
end
cache()

local menu = { 'VISUALS', 'Effects' } 

local xS = ui.new_slider(menu[1], menu[2], 'Additional Viewmodel X', -20, 20, xO)
local yS = ui.new_slider(menu[1], menu[2], 'Additional Viewmodel Y', -100, 100, yO)
local zS = ui.new_slider(menu[1], menu[2], 'Additional Viewmodel Z', -20, 20, zO)
local vS = ui.new_slider(menu[1], menu[2], 'Additional Viewmodel FOV", -60, 60, fO)

client.set_event_callback('paint', function()
    local viewmodel = 68 + ui.get(vS)
    local x = ui.get(xS)
    local y = ui.get(yS)
    local z = ui.get(zS)
    client.set_cvar('viewmodel_offset_x', x)
    client.set_cvar('viewmodel_offset_y', y)
    client.set_cvar('viewmodel_offset_z', z)
    client.set_cvar('viewmodel_fov', viewmodel)
end)
