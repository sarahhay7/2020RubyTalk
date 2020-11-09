require 'socket'

Socket.tcp_server_loop(2000) do |connection|
  puts connection.read
  connection.close
end
