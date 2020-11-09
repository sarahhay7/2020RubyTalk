require 'socket'

Socket.tcp_server_loop(2000) do |connection|
  connection.write("WELCOME!!")
  puts connection.inspect
  connection.close
end
