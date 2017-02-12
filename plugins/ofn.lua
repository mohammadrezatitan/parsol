--Start By edit by @mohammadrezajiii
local function is_channel_disabled( receiver )
 if not _config.disabled_channels then
  return false
 end

 if _config.disabled_channels[receiver] == nil then
  return false
 end

  return _config.disabled_channels[receiver]
end

local function enable_channel(receiver)
 if not _config.disabled_channels then
  _config.disabled_channels = {}
 end

 if _config.disabled_channels[receiver] == nil then
  return "*bot off❗️❌*"
 end
 
 _config.disabled_channels[receiver] = false

 save_config()
 return "*bot on✅♻️*"
end

local function disable_channel( receiver )
 if not _config.disabled_channels then
  _config.disabled_channels = {}
 end
 
 _config.disabled_channels[receiver] = true

 save_config()
 return "*bot off❗️❌*"
end

local function pre_process(msg)
 local receiver = msg.chat_id_
 
 if is_owner(msg) then
   if msg.content_.text_ == "/bot on" or msg.content_.text_ == "/Bot on" or msg.content_.text_ == "!bot on" or msg.content_.text_ == "!Bot on" then
     enable_channel(receiver)
   end
 end

  if is_channel_disabled(receiver) then
   msg.content_.text_ = ""
  end

 return msg
end

local function run(msg, matches)
 local receiver = msg.chat_id_
 
 local hash = 'usecommands:'..msg.sender_user_id_..':'..msg.chat_id_
    redis:incr(hash)
 if not is_owner(msg) then
 return '*شما مدیر ربات نیستید❗️🚷*'
 end
 if matches[1] == 'on' then
  return enable_channel(receiver)
 end
 if matches[1] == 'off' then
  return disable_channel(receiver)
 end
end

return {
 description = "Plugin to manage channels. Enable or disable channel.", 
 usage = {
  "/channel enable: enable current channel",
  "/channel disable: disable current channel" },
 patterns = {
  "^[!/][Bb]ot (on)",
  "^[!/][Bb]ot (off)" }, 
 run = run,
 moderated = true,
 pre_process = pre_process
}
--End By edit by @mohammadrezajiii
-- Channel 
