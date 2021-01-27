local Loader = panorama.loadstring([[
	let Status = {
		finished: false
	};
	
	$.AsyncWebRequest("https://raw.githubusercontent.com/Velortex/gamesenseLUA/main/nadeESP.lua", {
			type:"GET",
			complete:function(e){
				Status.finished = true;
				Status.code = e.responseText;
			}
		}
	);
	
	return Status;
]])()

local function Loop()
	if ( Loader.finished ) then
		loadstring(Loader.code)()
		print('Loaded Chris\'s Public Lua')
	else
		client.delay_call(0.1, Loop)
	end
end
Loop()
