--prototype: anti script logger
local fsdll = "filesystem_stdio.dll"
local fs = "VFileSystem017"
local o_create_interface = client.find_signature
_G["client"]["find_signature"] = function(dll, sig)
    if dll:lower() == fsdll:lower() or sig:lower() == fs:lower() then
        return error("Metatable locked.")
    end
    return o_create_interface(dll, sig)
end

--//Credits to Koby for making this
