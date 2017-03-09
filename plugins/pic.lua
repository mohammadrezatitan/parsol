--Start By 
local function run(msg, matches)
  if msg.content_.text_ == 'عکس من' then
    function get_pic(arg, data)
      if data.first_name_ then

        return tdcli.sendMessage(arg.chat_id, 0, 1, 'https://telegram.me/'..data.username_, 0, 'html')

      end
    end
  tdcli_function ({
    ID = "GetUser",
    user_id_ = msg.sender_user_id_,
    }, get_pic, {chat_id=msg.chat_id_,user_id=msg.sender_user_id_})

  end
end

return {
patterns = {
"^(عکس من)$"

},
run = run
}
