local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '#》*You are not bot admin*🚷'
else
     return '#》_شما مدیر ربات نیستید_🚷'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '#》*Group is already added*✅♻️'
else
return '#》_گروه در لیست گروه پشتیبان ربات قبلا بوده است✅♻️_'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'yes',
          lock_spam = 'yes',
          lock_webpage = 'no',
          lock_markdown = 'no',
          flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
          welcome = 'no',
         mute_fwd = 'no',
                  mute_audio = 'no',
                  mute_video = 'no',
                  mute_contact = 'no',
                  mute_text = 'no',
                  mute_photos = 'no',
                  mute_gif = 'no',
                  mute_loc = 'no',
                  mute_doc = 'no',
                  mute_sticker = 'no',
                  mute_voice = 'no',
                   mute_all = 'no',
           mute_keyboard = 'no'
          },
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '#》*Group has been added✅*'
else
  return '#》گروه به لیست گروه های پشتیبانی اضافه شد✅'
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '#》*Yσυ αяє ησт вσт α∂мιη*🚷'
   else
        return '#》_شما مدیر ربات نیستید_🚷'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '#》*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*'
else
    return '_#》گروه در لیست گروه های پشتیبانی نیست❌❗️_'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '*#》Gяσυρ нαѕ вєєη яємσνє∂✅*'
 else
  return '_#》گروه از لیست گروه های پشتیبانی حذف شد✅_'
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "#》_Wσя∂_ *"..word.."* _ιѕ αℓяєα∂у ƒιℓтєяє∂_♻️"
            else
         return "#》_کلمه_ *"..word.."* _از قبل فیلتر بود_♻️"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "#》_Wσя∂_ *"..word.."* _α∂∂є∂ тσ ƒιℓтєяє∂ ωσя∂ѕ ℓιѕт_✅"
            else
         return "#》_کلمه_ *"..word.."* _به لیست کلمات فیلتر اضافه شد_✅"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "#》_Wσя∂_ *"..word.."* _яємσνє∂ ƒяσм ƒιℓтєяє∂ ωσя∂ѕ ℓιѕт_❌"
       elseif lang then
         return "#》_کلمه_ *"..word.."* _از لیست کلمات فیلتر حذف شد_❌"
     end
      else
       if not lang then
         return "#》_Wσя∂_ *"..word.."* _ιѕ ησт ƒιℓтєяє∂_❕"
       elseif lang then
         return "#》_کلمه_ *"..word.."* _از قبل فیلتر نبود_❕"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "#》*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*"
 else
    return "_#》گروه در لیست گروه های پشتیبانی نیست❌❗️_"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "#》_Nσ_ *мσ∂єяαтσя* _ιη тнιѕ gяσυρ_❗️❕"
else
   return "#》_در این گروه هیچ معاونی برای ربات انتخاب نشده است❗️👤_"
  end
end
if not lang then
   message = '☆》📋*Lιѕт σƒ мσ∂єяαтσяѕ :*\n'
else
   message = '☆》📋لیست معاون های گروه \n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "#》*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*"
else
return "#》_در این گروه هیچ معاونی برای ربات انتخاب نشده است❗️👤_"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "#》_Nσ_ *σωηєя* _ιη тнιѕ gяσυρ_❕👤"
else
    return "#》هیچ مدیری برای ربات در این گروه انتخاب نشده است❕👤"
  end
end
if not lang then
   message = '☆》📋*Lιѕт σƒ мσ∂єяαтσяѕ :*\n'
else
   message = '☆》📋*لیست مدیران گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "#》*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_#》گروه درلیست گروه های پشتیبانی نیست❌❗️_", 0, "md")
     end
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *gяσυρ σωηєя*♻️", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر"..user_name.." *"..data.id_.."* *از قبل مدیر بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησω тнє_ *gяσυρ σωηєя*✅", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *مدیر گروه شد*✅", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *мσ∂єяαтσя*♻️", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون گروه بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *ρяσмσтє∂*✅", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *معاون گروه شد*✅", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *gяσυρ σωηєя*❌", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل مدیر نبود*❌", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ∂ємσтє σƒ_ *gяσυρ σωηєя*✅", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام مدیر برکنار شد*✅", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *мσ∂єяαтσя*❗️", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون نبود*❗️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *∂ємσтє∂*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام معاون گروه برکنار شد*✅", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "#》*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_#》گروه درلیست گروه های پشتیبانی نیست❌❗️_", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *gяσυρ σωηєя*♻️", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر"..user_name.." *"..data.id_.."* *از قبل مدیر بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησω тнє_ *gяσυρ σωηєя*✅", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *مدیر گروه شد*✅", 0, "md")   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *мσ∂єяαтσя*♻️", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون گروه بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *ρяσмσтє∂*✅", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *معاون گروه شد*✅", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *gяσυρ σωηєя*❌", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام مدیر برکنار شد*✅", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ∂ємσтє σƒ_ *gяσυρ σωηєя*✅", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام مدیر برکنار شد*✅", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *мσ∂єяαтσя*❗️", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون نبود*❗️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *∂ємσтє∂*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام معاون گروه برکنار شد*✅", 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "#》Rєѕυℓт ƒσя📄 [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "#》اطلاعات برای📄 [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "#》*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_#》گروه درلیست گروه های پشتیبانی نیست❌❗️_", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *gяσυρ σωηєя*♻️", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر"..user_name.." *"..data.id_.."* *از قبل مدیر بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησω тнє_ *gяσυρ σωηєя*✅", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *مدیر گروه شد*✅", 0, "md")   end
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *мσ∂єяαтσя*♻️", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون گروه بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *ρяσмσтє∂*✅", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *معاون گروه شد*✅", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *gяσυρ σωηєя*❌", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام مدیر برکنار شد*✅", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ∂ємσтє σƒ_ *gяσυρ σωηєя*✅", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام مدیر برکنار شد*✅", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *мσ∂єяαтσя*❗️", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون نبود*❗️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *∂ємσтє∂*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام معاون گروه برکنار شد*✅", 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = '☆》ησт ƒσυη∂❗️'
 else
username = '☆》ندارد❗️'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, '☆》Iηƒσ ƒσя📃 [ '..data.id_..' ] :\n👤UѕєяNαмє : '..username..'\n💎Nαмє : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, '☆》اطلاعات برای📃  [ '..data.id_..' ] :\n👤یوزرنیم : '..username..'\n💎نام : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "", 0, "md")
    end
  end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"]
if lock_link == "yes" then
if not lang then
 return "☆》*Lιηк* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》ارسال #لینک در گروه  از قبلا ممنوع است🔒"
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Lιηк* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》ارسال #لینک در گروه  از قبلا ممنوع است🔒"
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "☆》*Lιηк* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓"
elseif lang then
return "☆》ارسال #لینک در گروه  از قبلا ممنوع نیست🔓"
end
else
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data)
if not lang then
return "☆》*Lιηк* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓"
else
return "☆》ارسال #لینک در گروه  ازاد شد🔓"
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
if lock_tag == "yes" then
if not lang then
 return "☆》*Tαg* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》ارسال #هشتگ و یوزرنیم در گروه  از قبلا ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Tαg* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》ارسال #هشتگ و یوزرنیم در گروه ممنوع شد🔒"
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "☆》*Tαg* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓"
elseif lang then
return "☆》ارسال #هشتگ و یوزرنیم در گروه  از قبلا ممنوع نیست🔓"
end
else
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data)
if not lang then
return "☆》*Tαg* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓"
else
return "☆》ارسال #هشتگ و یوزرنیم در گروه  ازاد شد🔓"
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
if lock_mention == "yes" then
if not lang then
 return "☆》*Mєηтιση* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》ارسال #فراخوانی در گروه  از قبلا ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mєηтιση* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》ارسال #فراخوانی در گروه ممنوع شد🔒"
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "☆》*Mєηтιση* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓"
elseif lang then
return "☆》ارسال #فراخوانی در گروه  از قبلا ممنوع نیست🔓"
end
else
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mєηтιση* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓"
else
return "☆》ارسال # فراخوانی در گروه  ازاد شد🔓"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
if lock_arabic == "yes" then
if not lang then
 return "☆》*Pєяѕιαη* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》ارسال #کلمات فارسی در گروه  از قبلا ممنوع است🔒"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Pєяѕιαη* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》ارسال #کلمات فارسی در گروه ممنوع شد🔒"
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "no" then
if not lang then
return "☆》*Pєяѕιαη* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓"
elseif lang then
return "☆》ارسال #کلمات فارسی در گروه  از قبلا ممنوع نیست🔓"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data)
if not lang then
return "☆》*Pєяѕιαη* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓"
else
return "☆》ارسال # کلمات فارسی در گروه  ازاد شد🔓"
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
if lock_edit == "yes" then
if not lang then
 return "☆》*E∂ιтιηg* _Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》#ویرایش پیام در گروه  از قبل ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*E∂ιтιηg* _Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》#ویرایش پیام در گروه ممنوع شد🔒"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
return "☆》*E∂ιтιηg* _Iѕ Nσт Lσcкє∂_🔓"
elseif lang then
return "☆》#ویرایش پیام در گروه از قبل ممنوع نیست🔓"
end
else
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data)
if not lang then
return "☆》*E∂ιтιηg* _Hαѕ Bєєη Uηℓσcкє∂_🔓"
else
return "☆》#ویرایش پیام در گروه ازاد است🔓"
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
if lock_spam == "yes" then
if not lang then
 return "☆》*Sραм* _Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》ارسال #هرزنامه ( اسپم) در گروه  از قبلا ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Sραм* _Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》ارسال #هرزنامه ( اسپم) در گروه ممنوع شد🔒"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
return "☆》*Sραм* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓"
elseif lang then
 return "☆》ارسال #هرزنامه (اسپم) در گروه  از قبلا ممنوع نیست🔓"
end
else
data[tostring(target)]["settings"]["lock_spam"] = "no"
save_data(_config.moderation.data, data)
if not lang then
return "☆》*Sραм* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓"
else
 return "☆》ارسال #هرزنامه (اسپم) در گروه  ازاد شد🔓"
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"]
if lock_flood == "yes" then
if not lang then
 return "☆》*Fℓσσ∂ιηg* _Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》ارسال #پیام مکرر در گروه  از قبلا ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["flood"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Fℓσσ∂ιηg* _Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》ارسال # پیام مکرر در گروه ممنوع شد🔒"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "no" then
if not lang then
return "☆》*Flooding* _Is Not Locked_🔒"
elseif lang then
return "☆》ارسال #پیام مکرر در گروه  از قبلا ممنوع نیست🔓"
end
else
data[tostring(target)]["settings"]["flood"] = "no" save_data(_config.moderation.data, data)
if not lang then
return "☆》*Flooding* _Has Been Unlocked_🔒"
else
return "☆》ارسال #پیام مکرر در گروه  ازاد شد🔓"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
if lock_bots == "yes" then
if not lang then
 return "☆》*Bσтѕ* _Pяσтєcтιση Iѕ Aℓяєα∂у Eηαвℓє∂_🔒"
elseif lang then
 return "☆》#محافظت از گروه در برابر ربات ها از قبل فعال است🔒"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Bσтѕ* _Pяσтєcтιση Hαѕ Bєєη Eηαвℓє∂_🔒"
else
 return "☆》#محافظت از گروه در برابر ربات ها  فعال شد🔒"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "☆》*Bσтѕ* _Pяσтєcтιση Iѕ Nσт Eηαвℓє∂_🔓"
elseif lang then
return "محافظت از گروه در برابر ربات ها غیر فعال است"
end
else
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data)
if not lang then
return "☆》*Bσтѕ* _Pяσтєcтιση Hαѕ Bєєη Dιѕαвℓє∂_🔓"
else
return "☆》#محافظت از گروه در برابر ربات ها  ازاد است🔒"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
if lock_markdown == "yes" then
if not lang then
 return "☆》*Mαяк∂σωη* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》ارسال #پیام دارای فونت در گروه  از قبلا ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mαяк∂σωη* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》ارسال #پیام دارای فونت در گروه ممنوع شد🔒"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
return "☆》*Mαяк∂σωη* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓"
elseif lang then
return "☆》ارسال #پیام دارای فونت در گروه  از قبلا ممنوع نیست🔓"
end
else
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mαяк∂σωη* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓"
else
return "☆》ارسال #پیام درای فونت در گروه  ازاد شد🔓"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
if lock_webpage == "yes" then
if not lang then
 return "☆》*Wєвραgє* _Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》ارسال #صفحات وب در گروه  از قبلا ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Wєвραgє* _Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》ارسال #صفحات وب در گروه ممنوع شد🔒"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
return "☆》*Wєвραgє* _Iѕ Nσт Lσcкє∂_🔓"
elseif lang then
return "☆》ارسال #صفحات وب در گروه  از قبل ممنوع نیست🔓"
end
else
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data)
if not lang then
return "☆》*Wєвραgє* _Hαѕ Bєєη Uηℓσcкє∂_🔓"
else
return "☆》ارسال #صفحات وب در گروه  ازاد شد🔓"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
if lock_pin == "yes" then
if not lang then
 return "☆》*Pιηηє∂ Mєѕѕαgє* _Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》سنجاق کردن پیام در گروه از قبل ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Pιηηє∂ Mєѕѕαgє* _Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》سنجاق کردن پیام در گروه ممنوع شد🔒"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then
if not lang then
return "☆》*Pιηηє∂ Mєѕѕαgє* _Iѕ Nσт Lσcкє∂_🔓"
elseif lang then
return "☆》سنجاق کردن پیام در گروه ممنوع نمیباشد🔓"
end
else
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data)
if not lang then
return "☆》*Pιηηє∂ Mєѕѕαgє* _Hαѕ Bєєη Uηℓσcкє∂_🔓"
else
return "☆》سنجاق کردن پیام در گروه آزاد شد🔓"
end
end
end
--------Mutes---------
--------Mute all--------------------------
local function mute_all(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_all = data[tostring(target)]["settings"]["mute_all"]
if mute_all == "yes" then
if not lang then
return "☆》*Mυтє Aℓℓ* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
return "☆》بیصدا کردن #همه  از قبل فعال است🔇"
end
else
data[tostring(target)]["settings"]["mute_all"] = "yes"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Aℓℓ* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
return "☆》بیصدا کردن #همه فعال شد🔇"
end
end
end

local function unmute_all(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_all = data[tostring(target)]["settings"]["mute_all"]
if mute_all == "no" then
if not lang then
return "☆》*Mυтє Aℓℓ* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #همه فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_all"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Aℓℓ* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #همه غیر فعال شد🔊"
end
end
end

---------------Mute Gif-------------------
local function mute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_gif = data[tostring(target)]["settings"]["mute_gif"]
if mute_gif == "yes" then
if not lang then
 return "☆》*Mυтє Gιƒ* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #تصاویر متحرک  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_gif"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Gιƒ* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #تصاویر متحرک فعال شد🔇"
end
end
end

local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_gif = data[tostring(target)]["settings"]["mute_gif"]
 if mute_gif == "no" then
if not lang then
return "☆》*Mυтє Gιƒ* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #تصاویر متحرک فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_gif"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Gιƒ* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن # تصاویر متحرک غیر فعال شد🔊"
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_game = data[tostring(target)]["settings"]["mute_game"]
if mute_game == "yes" then
if not lang then
 return "☆》*Mυтє Gαмє* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #بازی های تحت وب  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_game"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Gαмє* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #بازی های تحت وب   فعال شد🔇"
end
end
end

local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_game = data[tostring(target)]["settings"]["mute_game"]
 if mute_game == "no" then
if not lang then
return "☆》*Mυтє Gαмє* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #بازی های تحت وب   فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Gαмє* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #بازی های تحت وب  غیر فعال شد🔊"
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_inline = data[tostring(target)]["settings"]["mute_inline"]
if mute_inline == "yes" then
if not lang then
 return "☆》*Mυтє Iηℓιηє* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #کیبورد شیشه ای از قبل فعال است🔊"
end
else
 data[tostring(target)]["settings"]["mute_inline"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Iηℓιηє* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #کیبورد شیشه ای فعال شد🔇"
end
end
end

local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_inline = data[tostring(target)]["settings"]["mute_inline"]
 if mute_inline == "no" then
if not lang then
return "☆》*Mυтє Iηℓιηє* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #کیبورد شیشه ای فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_inline"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Iηℓιηє* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #کیبورد شیشه ای  غیر فعال شد🔊"
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_text = data[tostring(target)]["settings"]["mute_text"]
if mute_text == "yes" then
if not lang then
 return "☆》*Mυтє Tєχт* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #متن  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_text"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Tєχт* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #متن فعال شد🔇"
end
end
end

local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_text = data[tostring(target)]["settings"]["mute_text"]
 if mute_text == "no" then
if not lang then
return "☆》*Mυтє Tєχт* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن # متن فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_text"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Tєχт* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن # متن غیر فعال شد🔊"
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_photo = data[tostring(target)]["settings"]["mute_photo"]
if mute_photo == "yes" then
if not lang then
 return "☆》*Mυтє Pнσтσ* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #عکس  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_photo"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Pнσтσ* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #عکس فعال شد🔇"
end
end
end

local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_photo = data[tostring(target)]["settings"]["mute_photo"]
 if mute_photo == "no" then
if not lang then
return "☆》*Mυтє Pнσтσ* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #عکس فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_photo"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Pнσтσ* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن # عکس غیر فعال شد🔊"
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_video = data[tostring(target)]["settings"]["mute_video"]
if mute_video == "yes" then
if not lang then
 return "☆》*Mυтє Vι∂єσ* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #ویدیو  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_video"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Vι∂єσ* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #ویدیو فعال شد🔇"
end
end
end

local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_video = data[tostring(target)]["settings"]["mute_video"]
 if mute_video == "no" then
if not lang then
return "☆》*Mυтє Vι∂єσ* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #ویدیو فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_video"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Vι∂єσ* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #ویدیو غیر فعال شد🔊"
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_audio = data[tostring(target)]["settings"]["mute_audio"]
if mute_audio == "yes" then
if not lang then
 return "☆》*Mυтє Aυ∂ισ* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #اهنگ  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_audio"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Aυ∂ισ* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
return "☆》بیصدا کردن #اهنگ فعال شد🔇"
end
end
end

local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_audio = data[tostring(target)]["settings"]["mute_audio"]
 if mute_audio == "no" then
if not lang then
return "☆》*Mυтє Aυ∂ισ* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #اهنگ فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Aυ∂ισ* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #اهنگ غیر فعال شد🔊"
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_voice = data[tostring(target)]["settings"]["mute_voice"]
if mute_voice == "yes" then
if not lang then
 return "☆》*Mυтє Vσιcє* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #صدا (وویس)  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_voice"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Vσιcє* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #صدا (وویس)  فعال شد🔇"
end
end
end

local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_voice = data[tostring(target)]["settings"]["mute_voice"]
 if mute_voice == "no" then
if not lang then
return "☆》*Mυтє Vσιcє* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #صدا (وویس) فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Vσιcє* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #صدا (وویس) غیر فعال شد🔊"
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_sticker = data[tostring(target)]["settings"]["mute_sticker"]
if mute_sticker == "yes" then
if not lang then
 return "☆》*Mυтє Sтιcкєя* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #استیکر  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_sticker"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Sтιcкєя* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #استیکر فعال شد🔇"
end
end
end

local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_sticker = data[tostring(target)]["settings"]["mute_sticker"]
 if mute_sticker == "no" then
if not lang then
return "☆》*Mυтє Sтιcкєя* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #استیکر فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Sтιcкєя* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #استیکر غیر فعال شد🔊"
end
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_contact = data[tostring(target)]["settings"]["mute_contact"]
if mute_contact == "yes" then
if not lang then
 return "☆》*Mυтє Cσηтαcт* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #ارسال مخاطب  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_contact"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Cσηтαcт* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #ارسال مخاطب فعال شد🔇"
end
end
end

local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_contact = data[tostring(target)]["settings"]["mute_contact"]
 if mute_contact == "no" then
if not lang then
return "☆》*Mυтє Cσηтαcт* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #ارسال مخطب فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_contact"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Cσηтαcт* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #ارسال مخاطب غیر فعال شد🔊"
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_forward = data[tostring(target)]["settings"]["mute_forward"]
if mute_forward == "yes" then
if not lang then
 return "☆》*Mυтє Fσяωαя∂* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #فوروارد از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_forward"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Fσяωαя∂* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #فوروارد فعال شد🔇"
end
end
end

local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_forward = data[tostring(target)]["settings"]["mute_forward"]
 if mute_forward == "no" then
if not lang then
return "☆》*Mυтє Fσяωαя∂* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #فوروارد فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Fσяωαя∂* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #فوروارد غیر فعال شد🔊"
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_location = data[tostring(target)]["settings"]["mute_location"]
if mute_location == "yes" then
if not lang then
 return "☆》*Mυтє Lσcαтιση* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #موقعیت  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_location"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Lσcαтιση* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #موقعیت فعال شد🔇"
end
end
end

local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_location = data[tostring(target)]["settings"]["mute_location"]
 if mute_location == "no" then
if not lang then
return "☆》*Mυтє Lσcαтιση* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #موقعیت فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_location"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Lσcαтιση* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #موقعیت غیر فعال شد🔊"
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_document = data[tostring(target)]["settings"]["mute_document"]
if mute_document == "yes" then
if not lang then
 return "☆》*Mυтє Dσcυмєηт* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #اسناد  از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_document"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Dσcυмєηт* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
 return "☆》بیصدا کردن #اسناد فعال شد🔇"
end
end
end

local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_document = data[tostring(target)]["settings"]["mute_document"]
 if mute_document == "no" then
if not lang then
return "☆》*Mυтє Dσcυмєηт* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #اسناد فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_document"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє Dσcυмєηт* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #اسناد غیر فعال شد🔊"
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_tgservice = data[tostring(target)]["settings"]["mute_tgservice"]
if mute_tgservice == "yes" then
if not lang then
 return "☆》*Mυтє TgSєяνιcє* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن #خدمات تلگرام از قبل فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_tgservice"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє TgSєяνιcє* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
return "☆》بیصدا کردن #خدمات تلگرام  فعال شد🔇"
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_tgservice = data[tostring(target)]["settings"]["mute_tgservice"]
 if mute_tgservice == "no" then
if not lang then
return "☆》*Mυтє TgSєяνιcє* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن #خدمات تلگرام فعال نیست🔊"
end
else
data[tostring(target)]["settings"]["mute_tgservice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє TgSєяνιcє* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن #خدمات تلگرام  غیرفعال شد🔊"
end
end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_keyboard = data[tostring(target)]["settings"]["mute_keyboard"]
if mute_keyboard == "yes" then
if not lang then
 return "☆》*Mυтє Kєувσαя∂* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔇"
elseif lang then
 return "☆》بیصدا کردن صفحه کلید فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_keyboard"] = "yes"
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Mυтє Kєувσαя∂* _Hαѕ Bєєη Eηαвℓє∂_🔇"
else
return "☆》بیصدا کردن صفحه کلید فعال شد🔇"
end
end
end

local function unmute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "#》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
return "#》_شما مدیر ربات نیستید_🚷"
end
end

local mute_keyboard = data[tostring(target)]["settings"]["mute_keyboard"]
 if mute_keyboard == "no" then
if not lang then
return "☆》*Mυтє Kєувσαя∂* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔊"
elseif lang then
return "☆》بیصدا کردن صفحه کلید غیرفعال است🔊"
end
else
data[tostring(target)]["settings"]["mute_keyboard"] = "no"
 save_data(_config.moderation.data, data)
if not lang then
return "☆》*Mυтє TgSєяνιcє* _Hαѕ Bєєη Dιѕαвℓє∂_🔊"
else
return "☆》بیصدا کردن صفحه کلید غیرفعال شد🔊"
end
end
end
----------Settings---------
local function group_settings(msg, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
  return "♯》*Yσυ αяє ησт вσт α∂мιη*🚷"
else
 return "#》_شما مدیر ربات نیستید_🚷"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id
if data[tostring(target)] then
if data[tostring(target)]["settings"]["num_msg_max"] then
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
  print('custom'..NUM_MSG_MAX)
else
NUM_MSG_MAX = 5
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_link"] then
data[tostring(target)]["settings"]["lock_link"] = "yes"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_tag"] then
data[tostring(target)]["settings"]["lock_tag"] = "yes"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_mention"] then
data[tostring(target)]["settings"]["lock_mention"] = "no"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_arabic"] then
data[tostring(target)]["settings"]["lock_arabic"] = "no"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_edit"] then
data[tostring(target)]["settings"]["lock_edit"] = "no"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_spam"] then
data[tostring(target)]["settings"]["lock_spam"] = "yes"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_flood"] then
data[tostring(target)]["settings"]["lock_flood"] = "yes"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_bots"] then
data[tostring(target)]["settings"]["lock_bots"] = "yes"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_markdown"] then
data[tostring(target)]["settings"]["lock_markdown"] = "no"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_webpage"] then
data[tostring(target)]["settings"]["lock_webpage"] = "no"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["welcome"] then
data[tostring(target)]["settings"]["welcome"] = "no"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["lock_pin"] then
data[tostring(target)]["settings"]["lock_pin"] = "no"
end
end

if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_all"] then
data[tostring(target)]["settings"]["mute_all"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_gif"] then
data[tostring(target)]["settings"]["mute_gif"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_text"] then
data[tostring(target)]["settings"]["mute_text"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_photo"] then
data[tostring(target)]["settings"]["mute_photo"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_video"] then
data[tostring(target)]["settings"]["mute_video"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_audio"] then
data[tostring(target)]["settings"]["mute_audio"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_voice"] then
data[tostring(target)]["settings"]["mute_voice"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_sticker"] then
data[tostring(target)]["settings"]["mute_sticker"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_contact"] then
data[tostring(target)]["settings"]["mute_contact"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_forward"] then
data[tostring(target)]["settings"]["mute_forward"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_location"] then
data[tostring(target)]["settings"]["mute_location"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_document"] then
data[tostring(target)]["settings"]["mute_document"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_tgservice"] then
data[tostring(target)]["settings"]["mute_tgservice"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_inline"] then
data[tostring(target)]["settings"]["mute_inline"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_game"] then
data[tostring(target)]["settings"]["mute_game"] = "no"
end
end
if data[tostring(target)]["settings"] then
if not data[tostring(target)]["settings"]["mute_keyboard"] then
data[tostring(target)]["settings"]["mute_keyboard"] = "no"
end
end
if not lang then
  local exp = redis:get("charged:"..msg.chat_id_)
    local day = 86400
    local ex = redis:ttl("charged:"..msg.chat_id_)
       if not exp or ex == -1 then
        expireen = "☆》_Eχριяє ∂αтє_ : *Unlimited*"
       else
        local d = math.floor(ex / day ) + 1
       expireen = "☆》_Eχριяє ∂αтє_ : *"..d.."* _day_"
   end
local settings = data[tostring(target)]["settings"]
 text ="*тıαивøт*\n*Groυp Seттιɴɢѕ:*\n*___________________________*\n*Group lock List* :\n☆》_Lσcк є∂ιт :_  *"..settings.lock_edit.."*\n☆》_Lσcк ℓιηкѕ :_  *"..settings.lock_link.."*\n☆》_Lσcк тαgѕ :_  *"..settings.lock_tag.."*\n☆》_Lσcк ƒℓσσ∂ :_  *"..settings.flood.."*\n☆》_Lσcк ѕραм :_  *"..settings.lock_spam.."*\n☆》_Lσcк мєηтιση :_  *"..settings.lock_mention.."*\n☆》_Lσcк αяαвιc :_  *"..settings.lock_arabic.."*\n☆》_Lσcк ωєвραgє :_  *"..settings.lock_webpage.."*\n☆》_Lσcк мαяк∂σωη :_  *"..settings.lock_markdown.."*\n☆》_Lσcк ριη мєѕѕαgє :_  *"..settings.lock_pin.."*\n*___________________________*\n☆》_Gяσυρ ωєℓcσмє :_  *"..settings.welcome.."*\n☆》_Bσтѕ ρяσтєcтιση :_  *"..settings.lock_bots.."*\n☆》_Fℓσσ∂ ѕєηѕιтινιту :_  *"..NUM_MSG_MAX.."*\n"..expireen.."\n*___________________________*\n*Group Mute List* : \n☆》_Mυтє αℓℓ : _  *"..settings.mute_all.."*\n☆》_Mυтє gιƒ :_  *"..settings.mute_gif.."*\n☆》_Mυтє тєχт :_  *"..settings.mute_text.."*\n☆》_Mυтє ιηℓιηє :_  *"..settings.mute_inline.."*\n☆》_Mυтє gαмє :_  *"..settings.mute_game.."*\n☆》_Mυтє ρнσтσ :_  *"..settings.mute_photo.."*\n☆》_Mυтє νι∂єσ :_  *"..settings.mute_video.."*\n☆》_Mυтє αυ∂ισ :_  *"..settings.mute_audio.."*\n☆》_Mυтє νσιcє :_  *"..settings.mute_voice.."*\n☆》_Mυтє ѕтιcкєя :_  *"..settings.mute_sticker.."*\n☆》_Mυтє cσηтαcт :_  *"..settings.mute_contact.."*\n☆》_Mυтє ƒσяωαя∂ :_  *"..settings.mute_forward.."*\n☆》_Mυтє ℓσcαтιση :_  *"..settings.mute_location.."*\n☆》_Mυтє ∂σcυмєηт :_  *"..settings.mute_document.."*\n☆》_Mυтє TgSєяνιcє :_  *"..settings.mute_tgservice.."*\n☆》_Mυтє Kєувσαя∂ :_  *"..settings.mute_keyboard.."*\n*___________________________*\n*channel*: @titantims\n_powered by_ :@mohammadrezajiji\n*Group Language* : *EN*"
else
 local exp = redis:get("charged:"..msg.chat_id_)
    local day = 86400
    local ex = redis:ttl("charged:"..msg.chat_id_)
       if not exp or ex == -1 then
        expirefa = "➕_تاریخ انقضا_ : *نامحدود*"
       else
        local d = math.floor(ex / day ) + 1
       expirefa = "➕_تاریخ انقضا_ : *"..d.."* _روز_"
   end
local settings = data[tostring(target)]["settings"]
 text = "*تیــتاטּ بوت*\n*تنظیـــᓄـات گروهــ:*\n*___________________________*\n لیــست ᓆــᓅـل هــا :\n🔒_قفل_ #ویرایش #پیام : *"..settings.lock_edit.."*\n_🔒قفل_ #لینک : *"..settings.lock_link.."*\n_🔒قفل_ #تگ : *"..settings.lock_tag.."*\n_🔒قفل_ #پیام #مکرر : *"..settings.flood.."*\n_🔒قفل_ #هرزنامه : *"..settings.lock_spam.."*\n_🔒قفل_ #فراخوانی : *"..settings.lock_mention.."*\n_🔒قفل_ #عربی : *"..settings.lock_arabic.."*\n_🔒قفل_ #صفحات #وب : *"..settings.lock_webpage.."*\n_🔒قفل_ #فونت : *"..settings.lock_markdown.."*\n_🔒قفل_ #سنجاق #کردن : *"..settings.lock_pin.."*\n*___________________________*\n_➕پیام خوشآمد گویی :_ *"..settings.welcome.."*\n_➕محافظت در برابر ربات ها :_ *"..settings.lock_bots.."*\n_➕حداکثر پیام مکرر :_ *"..NUM_MSG_MAX.."*\n"..expirefa.."\n*___________________________*\n *لیــست بیــصـבا هــا*:\n_🔇بیصدا_ همه :  *"..settings.mute_all.."*\n_🔇بیصدا_ #تصاویر #متحرک : *"..settings.mute_gif.."*\n_🔇بیصدا_ #متن : *"..settings.mute_text.."*\n_🔇بیصدا_ #کیبورد #شیشه #ای : *"..settings.mute_inline.."*\n_🔇بیصدا_ #بازی #تحت #وب : *"..settings.mute_game.."*\n_🔇بیصدا_ #عکس : *"..settings.mute_photo.."*\n_🔇بیصدا_ #فیلم : *"..settings.mute_video.."*\n_🔇بیصدا_ #آهنگ : *"..settings.mute_audio.."*\n_🔇بیصدا_ #وویس : *"..settings.mute_voice.."*\n_🔇بیصدا_ #برچسب : *"..settings.mute_sticker.."*\n_🔇بیصدا_ #ارسال #مخاطب : *"..settings.mute_contact.."*\n_🔇بیصدا_ #نقل #قول : *"..settings.mute_forward.."*\n_🔇بیصدا_ #موقعیت : *"..settings.mute_location.."*\n_🔇بیصدا_ #اسناد : *"..settings.mute_document.."*\n_🔇بیصدا_ #خدمات #تلگرام : *"..settings.mute_tgservice.."*\n_🔇بیصدا_ #صفحه #کلید : *"..settings.mute_keyboard.."*\n*___________________________*\n ڪانال ᓄا: @titantims\n ساختهـ شـבهـ توسط : @mohammadrezajiji\n_زبان سوپرگروه_ : *FA*"
end
text = string.gsub(text, "yes", "уєѕ")
text = string.gsub(text, "no", "ησ")
return text
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if msg.to.type ~= 'pv' then
if matches[1] == "id" or matches[1] == "ایدی" then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
   if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'Chat ID : '..msg.to.id..'\nUser ID : '..msg.from.id,dl_cb,nil)
       elseif lang then
          tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'شناسه گروه : '..msg.to.id..'\nشناسه شما : '..msg.from.id,dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "`You Have Not Profile Photo...!`\n\n> *Chat ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "_شما هیچ عکسی ندارید...!_\n\n> _شناسه گروه :_ `"..msg.to.id.."`\n_شناسه شما :_ `"..msg.from.id.."`", 1, 'md')
            end
        end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
end
if msg.reply_id and not matches[2] then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="id"})
  end
if matches[2] then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if matches[1] == "سنجاق" and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"]
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
    save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*🔗✅"
elseif lang then
return "پیام سنجاق شد🔗✅"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
    save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*🔗✅"
elseif lang then
return "پیام سنجاق شد🔗✅"
end
end
end
if matches[1] == 'حذف سنجاق' and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"]
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*🔗❌"
elseif lang then
return "پیام سنجاق شده پاک شد🔗❌"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*🔗❌"
elseif lang then
return "پیام سنجاق شده پاک شد🔗❌"
end
end
end
if matches[1] == "نصب" then
return modadd(msg)
end
if matches[1] == "حذف" then
return modrem(msg)
end
if matches[1] == "تنظیم مدیر" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if matches[1] == "حذف مدیر" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if matches[1] == "ترفیع" and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if matches[1] == "تنزل" and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

if matches[1] == "قفل" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "لینک" then
return lock_link(msg, data, target)
end
if matches[2] == "تگ" then
return lock_tag(msg, data, target)
end
if matches[2] == "فراخوانی" then
return lock_mention(msg, data, target)
end
if matches[2] == "فارسی" then
return lock_arabic(msg, data, target)
end
if matches[2] == "ویرایش پیام" then
return lock_edit(msg, data, target)
end
if matches[2] == "اسپم" then
return lock_spam(msg, data, target)
end
if matches[2] == "حساسیت" then
return lock_flood(msg, data, target)
end
if matches[2] == "ربات" then
return lock_bots(msg, data, target)
end
if matches[2] == "فونت" then
return lock_markdown(msg, data, target)
end
if matches[2] == "صفحات وب" then
return lock_webpage(msg, data, target)
end
if matches[2] == "سنجاق" and is_owner(msg) then
return lock_pin(msg, data, target)
end
end

if matches[1] == "بازکردن" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "لینک" then
return unlock_link(msg, data, target)
end
if matches[2] == "تگ" then
return unlock_tag(msg, data, target)
end
if matches[2] == "فراخوانی" then
return unlock_mention(msg, data, target)
end
if matches[2] == "فارسی" then
return unlock_arabic(msg, data, target)
end
if matches[2] == "ویرایش پیام" then
return unlock_edit(msg, data, target)
end
if matches[2] == "اسپم" then
return unlock_spam(msg, data, target)
end
if matches[2] == "حساسیت" then
return unlock_flood(msg, data, target)
end
if matches[2] == "ربات" then
return unlock_bots(msg, data, target)
end
if matches[2] == "فونت" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "صفحات وب" then
return unlock_webpage(msg, data, target)
end
if matches[2] == "سنجاق" and is_owner(msg) then
return unlock_pin(msg, data, target)
end
end
if matches[1] == "بیصدا" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "همه" then
return mute_all(msg, data, target)
end
if matches[2] == "گیف" then
return mute_gif(msg, data, target)
end
if matches[2] == "متن" then
return mute_text(msg ,data, target)
end
if matches[2] == "عکس" then
return mute_photo(msg ,data, target)
end
if matches[2] == "ویدیو" then
return mute_video(msg ,data, target)
end
if matches[2] == "اهنگ" then
return mute_audio(msg ,data, target)
end
if matches[2] == "ویس" then
return mute_voice(msg ,data, target)
end
if matches[2] == "استیکر" then
return mute_sticker(msg ,data, target)
end
if matches[2] == "مخاطب" then
return mute_contact(msg ,data, target)
end
if matches[2] == "فوروارد" then
return mute_forward(msg ,data, target)
end
if matches[2] == "مکان" then
return mute_location(msg ,data, target)
end
if matches[2] == "فایل" then
return mute_document(msg ,data, target)
end
if matches[2] == "خدمات تلگرام" then
return mute_tgservice(msg ,data, target)
end
if matches[2] == "دکمه شیشه ای" then
return mute_inline(msg ,data, target)
end
if matches[2] == "بازی" then
return mute_game(msg ,data, target)
end
if matches[2] == "کیبورد" then
return mute_keyboard(msg ,data, target)
end
end

if matches[1] == "باصدا" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "همه" then
return unmute_all(msg, data, target)
end
if matches[2] == "گیف" then
return unmute_gif(msg, data, target)
end
if matches[2] == "متن" then
return unmute_text(msg, data, target)
end
if matches[2] == "عکس" then
return unmute_photo(msg ,data, target)
end
if matches[2] == "ویدیو" then
return unmute_video(msg ,data, target)
end
if matches[2] == "اهنگ" then
return unmute_audio(msg ,data, target)
end
if matches[2] == "ویس" then
return unmute_voice(msg ,data, target)
end
if matches[2] == "استیکر" then
return unmute_sticker(msg ,data, target)
end
if matches[2] == "مخاطب" then
return unmute_contact(msg ,data, target)
end
if matches[2] == "فوروارد" then
return unmute_forward(msg ,data, target)
end
if matches[2] == "مکان" then
return unmute_location(msg ,data, target)
end
if matches[2] == "فایل" then
return unmute_document(msg ,data, target)
end
if matches[2] == "خدمات تلگرام" then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == "دکمه شیشه ای" then
return unmute_inline(msg ,data, target)
end
if matches[2] == "بازی" then
return unmute_game(msg ,data, target)
end
if matches[2] == "کیبورد" then
return unmute_keyboard(msg ,data, target)
end
end
if matches[1] == "اطلاعات گروه" and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "*Group Info :*\n_👤Admin Count :_ *"..data.administrator_count_.."*\n_👥Member Count :_ *"..data.member_count_.."*\n_👥❌Kicked Count :_ *"..data.kicked_count_.."*\n🆔_Group ID :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
elseif lang then
ginfo = "*اطلاعات گروه :*\n👤_تعداد مدیران :_ *"..data.administrator_count_.."*\n_👥تعداد اعضا :_ *"..data.member_count_.."*\n_👥❌تعداد اعضای حذف شده :_ *"..data.kicked_count_.."*\n🆔_شناسه گروه :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if matches[1] == 'لینک جدید' and is_mod(msg) then
      local function callback_link (arg, data)
   local hash = "gp_lang:"..msg.to.id
   local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
        if not data.invite_link_ then
          administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
          save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator [لینک جدید] for group with using_ /setlink", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_ربات سازنده گروه نیست_\n_با دستور_ [لینک جدید] _لینک جدیدی برای گروه ثبت کنید_", 1, 'md')
    end
        else
          administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
          save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Newlink Created*✅", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_لینک جدید ساخته شد_✅", 1, 'md')
            end
        end
      end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
    end
    if matches[1] == 'تنظیم لینک' and is_owner(msg) then
      data[tostring(chat)]['settings']['linkgp'] = 'waiting'
      save_data(_config.moderation.data, data)
      if not lang then
      return '_Please send the new group_ *link* _now_✅'
    else
         return 'لطفا لینک گروه خود را ارسال کنید✅'
       end
    end

    if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
      if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
        data[tostring(chat)]['settings']['linkgp'] = msg.text
        save_data(_config.moderation.data, data)
            if not lang then
        return "*Newlink* _has been set_✅"
           else
           return "لینک جدید ذخیره شد✅"
      end
       end
    end
    if matches[1] == 'لینک' and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ [لینک جدید]\n_If bot not group creator set a link with using_ [تنظیم لینک]"
     else
        return "ابتدا با دستور [لینک جدید] لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور [تنظیم لینک] لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
       text = "<b>Group Link :</b>\n"..linkgp
     else
      text = "<b>لینک گروه :</b>\n"..linkgp
         end
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
    if matches[1] == 'لینک پیوی' and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ [لینک جدید]\n_If bot not group creator set a link with using_ [تنظیم لینک]"
     else
        return "ابتدا با دستور [لینک جدید] لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور [تنظیم لینک] لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
     tdcli.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
     else
      tdcli.sendMessage(user, "", 1, "<b>لینک گروه "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
         end
      if not lang then
        return "*Group Link Was Send In Your Private Message*✅"
       else
        return "_لینک گروه به چت خصوصی شما ارسال شد_✅"
        end
     end
  if matches[1] == "تنظیم قوانین" and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
    save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules* _has been set_✅"
   else
  return "قوانین گروه ثبت شد✅"
   end
  end
  if matches[1] == "درباره" then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@titantims"
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@titantims"
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if matches[1] == "اطلاعات یوزرنیم" and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if matches[1] == "اطلاعات ایدی" and matches[2] and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
  if matches[1] == 'تنظیم حساسیت' and is_mod(msg) then
      if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
        return "_Wrong number, range is_ *[1-50]*❕"
      end
      local flood_max = matches[2]
      data[tostring(chat)]['settings']['num_msg_max'] = flood_max
      save_data(_config.moderation.data, data)
    return "_Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*✅"
       end
    if matches[1]:lower() == 'پاک کردن' and is_owner(msg) then
      if matches[2] == ' لیست معاون ها' then
        if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
          return "_No_ *moderators* _in this group_❕"
             else
                return "هیچ معاونی برای گروه انتخاب نشده است❕"
        end
            end
        for k,v in pairs(data[tostring(chat)]['mods']) do
          data[tostring(chat)]['mods'][tostring(k)] = nil
          save_data(_config.moderation.data, data)
        end
            if not lang then
        return "_All_ *moderators* _has been demoted_"
          else
            return "تمام معاونان گروه تنزیل مقام شدند"
      end
         end
      if matches[2] == 'لیست فیلتر' then
        if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
          return "*Filtered words list* _is empty_❕"
         else
          return "_لیست کلمات فیلتر شده خالی است_ر"
             end
        end
        for k,v in pairs(data[tostring(chat)]['filterlist']) do
          data[tostring(chat)]['filterlist'][tostring(k)] = nil
          save_data(_config.moderation.data, data)
        end
       if not lang then
        return "*Filtered words list* _has been cleaned_✅"
           else
        return "_لیست کلمات فیلتر شده پاک شد_✅"
           end
      end
      if matches[2] == 'قوانین' then
        if not data[tostring(chat)]['rules'] then
            if not lang then
          return "_No_ *rules* _available_❕"
             else
               return "قوانین برای گروه ثبت نشده است❕"
             end
        end
          data[tostring(chat)]['rules'] = nil
          save_data(_config.moderation.data, data)
             if not lang then
        return "*Group rules* _has been cleaned_✅"
          else
            return "قوانین گروه پاک شد✅"
      end
       end
      if matches[2] == 'خوش امد' then
        if not data[tostring(chat)]['setwelcome'] then
            if not lang then
          return "*Welcome Message not set*❕"
             else
               return "پیام خوشآمد گویی ثبت نشده است❕"
             end
        end
          data[tostring(chat)]['setwelcome'] = nil
          save_data(_config.moderation.data, data)
             if not lang then
        return "*Welcome message* _has been cleaned_✅"
          else
            return "پیام خوشآمد گویی پاک شد✅"
      end
       end
      if matches[2] == 'درباره' then
        if msg.to.type == "chat" then
        if not data[tostring(chat)]['about'] then
            if not lang then
          return "_No_ *description* _available❕_"
            else
              return "پیامی مبنی بر درباره گروه ثبت نشده است❕"
          end
        end
          data[tostring(chat)]['about'] = nil
          save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
             if not lang then
        return "*Group description* _has been cleaned_✅"
           else
              return "پیام مبنی بر درباره گروه پاک شد✅"
             end
        end
        end
    if matches[1]:lower() == 'پاک کردن' and is_admin(msg) then
      if matches[2] == 'لیست مدیران' then
        if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
          return "_No_ *owners* _in this group_❕"
            else
                return "مالکی برای گروه انتخاب نشده است❕"
            end
        end
        for k,v in pairs(data[tostring(chat)]['owners']) do
          data[tostring(chat)]['owners'][tostring(k)] = nil
          save_data(_config.moderation.data, data)
        end
            if not lang then
        return "_All_ *owners* _has been demoted_✅"
           else
            return "تمامی مالکان گروه تنزیل مقام شدند✅"
          end
      end
     end
if matches[1] == "تنظیم نام" and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if matches[1] == "تنظیم درباره" and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
    save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_✅"
    else
     return "پیام مبنی بر درباره گروه ثبت شد✅"
      end
  end
  if matches[1] == "درباره" and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_No_ *description* _available_❕"
      elseif lang then
      about = "پیامی مبنی بر درباره گروه ثبت نشده است❕"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if matches[1] == 'فیلتر' and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if matches[1] == 'حذف فیلتر' and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if matches[1] == 'لیست فیلتر' and is_mod(msg) then
    return filter_list(msg)
  end
if matches[1] == "تنظیمات" then
return group_settings(msg, target)
end
if matches[1] == "لیست معاون ها" then
return modlist(msg)
end
if matches[1] == "لیست مدیران" and is_owner(msg) then
return ownerlist(msg)
end

if matches[1] == "تنظیم زبان" and is_owner(msg) then
   if matches[2] == "انگلیسی" then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 redis:del(hash)
return "_Group Language Set To:_ EN✅"
  elseif matches[2] == "فارسی" then
redis:set(hash, true)
return "*زبان گروه تنظیم شد به : فارسی*✅"
end
end

if matches[1] == "راهنما" and is_mod(msg) then
text = [[
*📜Help of 🛡titan🛡 tg*
#Titantg🏷
〰〰〰〰〰〰〰〰〰〰〰
🔖راهنمای دستورات :

📋دستورات قفلی
شامل دستورات قفل کردن و بازکردن قفل ها

📋دستورات مدیریتی
شامل دستورات برای مدیریت گروه

📋دستورات فان
شامل دستورات عمومی و سرگرم کننده
〰〰〰〰〰〰〰〰〰〰〰
🔷شما مدیران و ادمین های ربات میتوانید لیست دستودات مورد نظر را با واردن کردن ان ببنید

🔶ربات دارای دو زبان پاسخ گویی به دستورات است که شما عزیزان میتوانید به دستور :

تنظیم زبان [فارسی - انگلیسی]

زبان پاسخ گویی ربات به دستورات رو تغییر دهید

مثال : تنظیم زبان فارسی

🔶دستورات سودو
نمایش دستورات صاحب ربات
*___________________________*
*Channel*: @titantims
_powered by_ :@mohammadrezajiji
]]
return text
end
if matches[1] == "دستورات قفلی" and is_mod(msg) then
text = [[
🔶پاک کردن لینک
🔹*قفل لینک*
🔸*بازکردن لینک*

🔷پاک کردن هشتگ و یوزرنیم
🔹*قفل تگ*
🔸*بازکردن تگ*

🔶پاک کردن فراخوانی
🔹*قفل فراخوانی*
🔸*بازکردن فراخوانی*

🔶پاک کردن نوشتن فارسی
🔹*قفل فارسی*
🔸*بازکردن فارسی*

🔷پاک کردن ویرایش پیام
🔹*قفل ویرایش پیام*
🔸*بازکردن ویرایش پیام*

🔶پاک کردن هرزنامه(پیام بلند)
🔹*قفل اسپم*
🔸*بازکردن اسپم*

🔷پاک کردن تعداد پیام مکرر و حدف فرد
🔹*قفل حساسیت*
🔸*بازکردن حساسیت*

🔶پاک کردن ربات های مخرب
🔹*قفل ربات*
🔸*بازکردن ربات*

🔷پاک کردن فونت خاص
🔹*قفل فونت*
🔸*بازکردن فونت*

🔶پاک کردن صفحات وب
🔹*قفل صفحات وب*
🔸*بازکردن صفحات وب*

🔷پاک کردن پین پیام
🔹*قفل سنجاق*
🔸*بازکردن سنجاق*

🔶پاک کردن همه پیام ها
🔹*بیصدا همه*
🔸*باصدا همه*

🔷پاک کردن تصاویر متحرک
🔹*بیصدا گیف*
🔸*باصدا گیف*

🔶پاک کردن متن
🔹*بیصدا متن*
🔸*باصدا متن*

🔷پاک کردن عکس
🔹*بیصدا عکس*
🔸*باصدا عکس*

🔶پاک کردن فیلم
🔹*بیصدا ویدیو*
🔸*باصدا ویدیو*

🔷پاک کردن اهنگ
🔹*بیصدا اهنگ*
🔸*باصدا اهنگ*

🔶پاک کردن ویس
🔹*بیصدا ویس*
🔸*باصدا ویس*

🔷پاک کردن استیکر
🔹*بیصدا استیکر*
🔸*باصدا استیکر*

🔶پاک کردن ارسال مخاطب
🔹*بیصدا مخاطب*
🔸*باصدا مخاطب*

🔷پاک کردن فوروارد
🔹*بیصدا فوروارد*
🔸*باصدا فوروارد*

🔶پاک کردن ارسال مکان
🔹*بیصدا مکان*
🔸*باصدا مکان*

🔷پاک کردن ارسال فایل
🔹*بیصدا فایل*
🔸*باصدا فایل*

🔶پاک کردن خدمات تلگرام
🔹*بیصدا خدمات تلگرام*
🔸*باصدا خدمات تلگرام*

🔷پاک کردن دکمه شیشه ای
🔹*بیصدا دکمه شیشه ای*
🔸*باصدا دکمه شیششه ای*

🔶پاک کردن بازی تحت وب
🔹*بیصدا بازی*
🔸*باصدا بازی*

🔷پاک کردن کیبورد
🔹*بیصدا کیبورد*
🔸*باصدا کیبورد*
*___________________________*
*کانال*: @titantims
سازنده :@mohammadrezajiji
]]
return text
end
if matches[1] == "دستورات مدیریتی" and is_mod(msg) then
text = [[
*Tιтαη вσт*
*تنظیم مدیر* `[یوزرنیم|ایدی|ریپلای]`
🔹انتخاب مدیر گروه(قابل انتخاب چند مالک)

*حذف مدیر* `[یوزرنیم|ایدی|ریپلای]`
🔹حذف کردن فرد از فهرست مدیران گروه

*ترفیع* `[یوزرنیم|ایدی|ریپلای]`
🔹ارتقا مقام کاربر به معاون گروه

*تنزل* `[یوزرنیم|ایدی|ریپلای]`
🔹تنزیل مقام مدیر به کاربر

*تنظیم حساسیت* `[1-50]`
🔹تنظیم حداکثر تعداد پیام مکرر


*صامت* `[یوزرنیم|ایدی|ریپلای]`
🔹بیصدا کردن کاربر در گروه


*مصوت* `[یوزرنیم|ایدی|ریپلای]`
🔹در آوردن کاربر از حالت بیصدا در گروه

*اخراج* `[یوزرنیم|ایدی|ریپلای]`
🔹حذف کاربر از گروه

*مسدود* `[یوزرنیم|ایدی|ریپلای]`
🔹مسدود کردن کاربر از گروه

*ازاد* `[یوزرنیم|ایدی|ریپلای]`
🔹در آوردن از حالت مسدودیت کاربر از گروه

*اطلاعات یوزرنیم* `[یوزرنیم]`
🔹نمایش شناسه کاربر

*ایدی* `[ریپلای]`
🔹نمایش شناسه کاربر

*اطلاعات ایدی* `[ایدی]`
🔹نمایش نام کاربر, نام کاربری و اطلاعات حساب

*قفل* `[لینک | تگ | ویرایش پیام | فارسی | صفحات وب | ربات | اسپم | حساسیت | فراخوانی | فونت | سنجاق]`

🔹در صورت قفل بودن فعالیت ها, ربات آنهارا حذف خواهد کرد

*بازکردن* `[لینک | تگ | ویرایش پیام | فارسی | صفحات وب | ربات | اسپم | حساسیت | فراخوانی | فونت | سنجاق]`

🔹در صورت قفل نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد

*بیصدا* `[گیف | عکس | فایل | استیکر | کیبورد | ویدیو | متن | فوروارد | مکان | اهنگ | ویس | مخاطب| همه]`

🔹در صورت بیصدد بودن فعالیت ها, ربات آنهارا حذف خواهد کرد

*باصدا* `[گیف | عکس | فایل | استیکر | کیبورد | ویدیو | متن | فوروارد | مکان | اهنگ | ویس | مخاطب| همه]`

🔹در صورت بیصدا نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد

*تنظیم*`[قوانین |  | عکس | لینک | درباره | خوش امد]`
🔹ربات آنهارا ثبت خواهد کرد

*پاک کردن* `[مسدود ها | لیست معاون ها | ربات | قوانین | درباره | لیست ساکت ها | لیست فیلتر | خوش امد]`
🔹ربات آنهارا پاک خواهد کرد

*فیلتر* `[کلمه]`
🔹فیلتر‌کلمه مورد نظر

*حذف فیلتر* `[کلمه]`
🔹ازاد کردن کلمه مورد نظر

*سنجاق* `[ریپلای]`
🔹ربات پیام شمارا در گروه سنجاق خواهد کرد

*حذف سنجاق*
🔹ربات پیام سنجاق شده در گروه را حذف خواهد کرد

*خوش امد [روشن-خاموش]*
🔹فعال یا غیرفعال کردن خوشآمد گویی

*تنظیمات*
🔹نمایش تنظیمات گروه

*لیست ساکت ها*
🔹نمایش فهرست افراد بیصدا

*لست غیلتر*
🔹نمایش لیست کلمات فیلتر شده

*لیست مسدود ها*
🔹نمایش افراد مسدود شده از گروه

*لیست مدیران*
🔹نمایش فهرست مدیران گروه

*لیست معاون ها*
🔹نمایش فهرست معاون های گروه

*قوانین*
🔹نمایش قوانین گروه

*درباره*
🔹نمایش درباره گروه

*ایدی*
نمایش شناسه شما و گروه

*اطلاعات گروه*
🔹نمایش اطلاعات گروه

*لینک جدید*
🔹ساخت لینک جدید

*لینک*
🔹نمایش لینک گروه

*لینک پیوی*
ارسال لینک گروه به چت خصوصی شما

*تنظیم خوش امد [متن]*
🔹ثبت پیام خوش آمد گویی

*پاک کردن * [1-100]
🔹پاک کردن تعداد پیام اخیر سورپر گروه

*پاک کردن پیام ها [ریپلای]*
🔹پاک کردن تمام پیام های فرد در گروه
*___________________________*
*کانال*: @titantims
سازنده :@mohammadrezajiji
]]
return text
end

--------------------- Welcome -----------------------
  if matches[1] == "خوش امد" and is_mod(msg) then
    if matches[2] == "روشن" then
      welcome = data[tostring(chat)]['settings']['welcome']
      if welcome == "yes" then
       if not lang then
        return "_Group_ *welcome* _is already enabled_"
       elseif lang then
        return "_خوشآمد گویی از قبل فعال بود_"
           end
      else
    data[tostring(chat)]['settings']['welcome'] = "yes"
      save_data(_config.moderation.data, data)
       if not lang then
        return "_Group_ *welcome* _has been enabled_"
       elseif lang then
        return "_خوشآمد گویی فعال شد_"
          end
      end
    end

    if matches[2] == "خاموش" then
      welcome = data[tostring(chat)]['settings']['welcome']
      if welcome == "no" then
      if not lang then
        return "_Group_ *Welcome* _is already disabled_"
      elseif lang then
        return "_خوشآمد گویی از قبل فعال نبود_"
         end
      else
    data[tostring(chat)]['settings']['welcome'] = "no"
      save_data(_config.moderation.data, data)
      if not lang then
        return "_Group_ *welcome* _has been disabled_"
      elseif lang then
        return "_خوشآمد گویی غیرفعال شد_"
          end
      end
    end
  end
  if matches[1] == "تنظیم خوش امد" and matches[2] and is_mod(msg) then
    data[tostring(chat)]['setwelcome'] = matches[2]
      save_data(_config.moderation.data, data)
       if not lang then
    return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"
       else
    return "_پیام خوشآمد گویی تنظیم شد به :_\n*"..matches[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n_استفاده کنید_"
        end
     end
  end
end
-----------------------------------------
local function pre_process(msg)
   local chat = msg.to.id
   local user = msg.from.id
 local data = load_data(_config.moderation.data)
  local function welcome_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*Welcome *"
    elseif lang then
     welcome = "_خوش آمدید_"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@titantims"
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@titantims"
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
    local welcome = welcome:gsub("{rules}", rules)
    local welcome = welcome:gsub("{name}", check_markdown(data.first_name_))
    local welcome = welcome:gsub("{username}", user_name)
    local welcome = welcome:gsub("{gpname}", arg.gp_name)
    tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
  end
  if data[tostring(chat)] and data[tostring(chat)]['settings'] then
  if msg.adduser then
    welcome = data[tostring(msg.to.id)]['settings']['welcome']
    if welcome == "yes" then
      tdcli_function ({
        ID = "GetUser",
        user_id_ = msg.adduser
      }, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
    else
      return false
    end
  end
  if msg.joinuser then
    welcome = data[tostring(msg.to.id)]['settings']['welcome']
    if welcome == "yes" then
      tdcli_function ({
        ID = "GetUser",
        user_id_ = msg.joinuser
      }, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
    else
      return false
        end
    end
  end
  -- return msg
 end
return {
patterns ={
"^(ایدی)$",
"^(ایدی) (.*)$",
"^(سنجاق)$",
"^(حذف سنجاق)$",
"^(اطلاعات گروه)$",
"^(test)$",
"^(نصب)$",
"^(حذف)$",
"^(تنظیم مدیر)$",
"^(تنظیم مدیر) (.*)$",
"^(حذف مدیر)$",
"^(حذف مدیر) (.*)$",
"^(ترفیع)$",
"^(ترفیع) (.*)$",
"^(تنزل)$",
"^(تنزل) (.*)$",
"^(لیست معاون ها)$",
"^(لیست مدیران)$",
"^(قفل) (.*)$",
"^(بازکردن) (.*)$",
"^(تنظیمات)$",
"^(بیصدا) (.*)$",
"^(باصدا) (.*)$",
"^(لینک)$",
"^(راهنما)$",
"^(دستورات مدیریتی)$",
"^(دستورات قفلی)$",
"^(لینک پیوی)$",
"^(تنظیم لینک)$",
"^(لینک جدید)$",
"^(قوانین)$",
"^(تنظیم قوانین) (.*)$",
"^(دباره)$",
"^(تنظیم درباره) (.*)$",
"^(تنظیم نام) (.*)$",
"^(پلک کردن) (.*)$",
"^(تنظیم حساسیت) (%d+)$",
"^(اطلاعات یوزرنیم) (.*)$",
"^(اطلاعات ایدی) (%d+)$",
"^(خوش امد)$",
"^(تنظیم زبان) (.*)$",
"^(فیلتر) (.*)$",
"^(حذف فیلتر) (.*)$",
"^(لیست فیلتر)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^(تنظیم خوش امد) (.*)",
"^(خوش امد) (.*)$"

},
run=run,
pre_process = pre_process
}
--end groupmanager.lua #@mohammadrezajiji
