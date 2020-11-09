require 'socket'

one_kilobyte = 1024

Socket.tcp_server_loop(2000) do |connection|

  # read 1kb at a time and `puts` as we go
  while data = connection.read(one_kilobyte) do
    puts data
  end

  connection.close
end

