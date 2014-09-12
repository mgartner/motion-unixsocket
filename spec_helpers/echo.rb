require 'socket'

UNIXServer.open("sock") do |server|
  s = server.accept
  msg = s.readline
  s.puts msg
end
