local skynet=require "skynet"
local socket=require "skynet.socket"

local clients={}

skynet.start(function()
    local listenfd=socket.listen("0.0.0.0",8888)
    socket.start(listenfd, connect)
end)

function connect(fd, addr) 
    print(fd.."connected addr:"..addr)
    socket.start(fd)
    clients[fd]={}

    while true do
        local readdata=socket.read(fd) 
        if readdata~=nil then
            print(fd.." recv "..readdata)
            for i,_ in pairs(clients) do 
                socket.write(i,readdata)
            end
        else
            print(fd.." close ")
            socket.close(fd)
            clients[fd]=nil
            break
        end
    end
end
