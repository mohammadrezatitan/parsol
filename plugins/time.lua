-- Begin time.lua
function run(msg, matches) 
	local url , res = http.request('http://api.gpmod.ir/time/')
	local jdat = json:decode(url)
	local url1 = "http://latex.codecogs.com/png.download?".."\\dpi{500}%10\\LARGE%75"..jdat.ENtime
	function dlURL(url, fileName)
		local respbody = {}
		local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true }
		local response = nil
		response = {http.request(options)}
		local responsive = response[2]
		if responsive ~= 200 then return nil end
		local filePath = "data/"..fileName
		file = io.open(filePath, "w+")
		file:write(table.concat(respbody))
		file:close()
		return filePath
	end
	local file1 = dlURL(url1,'time1.webp')
	tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, file1, '', dl_cb, nil)
end 

return { patterns = { "^!time$", "^/time$" , "^#time$" }, run = run } 

-- 
-- 
-- 