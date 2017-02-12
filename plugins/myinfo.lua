
local function run(msg, matches)
	if matches[1]:lower() == 'info' then
		function get_id(arg, data)
			local username
			if data.first_name_ then
				if data.username_ then
					username = '@'..data.username_
				else
					username = 'user not found'
				end
				local telNum
				if data.phone_number_ then
					telNum = '+'..data.phone_number_
				else
					telNum = '----'
				end
				local lastName
				if data.last_name_ then
					lastName = data.last_name_
				else
					lastName = '----'
				end
				local rank
				if is_sudo(msg) then
					rank = '<b>sudo</b>'
				elseif is_owner(msg) then
					rank = '<b>owner</b>'
				elseif is_admin(msg) then
					rank = '<b>admin👤</b>'
				elseif is_mod(msg) then
					rank = '<b>mod</b>'
				else
					rank = '<b>member</b>'
				end
				local text = '👤📄❄️<b>your info</b>:\n<b>1⃣name:</b> '..data.first_name_..'\n⃣<b>last name:</b> '..lastName..'\n🛂<b>username:</b> '..username..'\n👤<b>id:</b> '..data.id_..'\nℹ️<b>group id:</b> '..arg.chat_id..'\n📱<b>number</b>: '..telNum..' \n👥<b>rank:</b> '..rank..'\n🈁<b>link</b> : telegram.me/'..data.username_
				tdcli.sendMessage(arg.chat_id, msg.id_, 1, text, 0, 'html')
			end
		end
		tdcli_function({ ID = 'GetUser', user_id_ = msg.sender_user_id_, }, get_id, {chat_id=msg.chat_id_, user_id=msg.sendr_user_id_})
	end
end

return { patterns = { "^[!/#](info)$" }, run = run }

-- END
-- edit by @mohammadrezajiii
-- CHANNEL: 
-- We Are The Best :-)
