
local function pre_process(msg)
  local hash = 'mute_time:'..msg.chat_id_
  if redis:get(hash) and gp_type(msg.chat_id_) == 'channel' and not is_admin(msg)  then
    tdcli.deleteMessages(msg.chat_id_, {[0] = tonumber(msg.id_)})
  end
 end
 
local function run(msg, matches)
  if matches[1]:lower() == 'mt' and is_admin(msg) then
     local hash = 'mute_time:'..msg.chat_id_
     if not matches[2] then
    return "*Please enter the hours and minutes*"
  else
     local hour = string.gsub(matches[2], 'h', '')
     local num1 = tonumber(hour) * 3600
     local minutes = string.gsub(matches[3], 'm', '')
     local num2 = tonumber(minutes) * 60
     local num4 = tonumber(num1 + num2)
   redis:setex(hash, num4, true)
     return "*⛔️group muted all of*: \n`"..matches[2].."` *hours*\n`"..matches[3].."` *Minute*"
    end
  end
  if matches[1]:lower() == 'unmt' and is_admin(msg) then
     local hash = 'mute_time:'..msg.chat_id_
     redis:del(hash)
     return "*Group to send a message is opened.*"
  end
end
return {
   patterns = {
      '^[!/#]([Mm][Tt])$',
      '^[!/#]([Uu][Nn][Mm][Tt])$',
    '^[!/#]([Mm][Tt]) (%d+) (%d+)$',
 },
  run = run,
  pre_process = pre_process
}
--end by #edit by @mohammadrezajiii
