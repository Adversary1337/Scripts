local Loader = panorama.loadstring([[
	let Status = {
		finished: false
	};
	
	$.AsyncWebRequest("https://github.com/theriojunior/Scripts/raw/main/luas/penetration_damage.lua", {
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
	else
		client.delay_call(0.1, Loop)
	end
end
Loop()