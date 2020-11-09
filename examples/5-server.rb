require 'socket'

one_hundred_kilobytes = 1024 * 100
chunk_size = one_hundred_kilobytes

Socket.tcp_server_loop(2000) do |connection|
  begin
    # read data in chunks of up to 100kb or less
    while data = connection.readpartial(chunk_size) do
      puts data
    end
  rescue EOFError # readpartial raises EOF when EOF encountered
  end

  # Until the client is closed, you will continue to listen
  connection.close
end
