local skynet = require "skynet"
local mysql = require "skynet.db.mysql"


skynet.start(function()
    local db=mysql.connect({
        host="192.168.153.128",
        port=3306,
        database="message_board",
        user="root",
        password="6557632Weng@",
        max_packet_size=1024*1024,
        on_connect=nil
    })

    local res=db:query("insert into msgs(text) values(\'hehe\')")
    res=db:query("select * from msgs")
    for i,v in pairs(res) do
        print(i," ",v.id," ",v.text)
    end
end
)