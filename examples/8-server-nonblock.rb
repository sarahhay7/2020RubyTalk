require 'socket'

Socket.tcp_server_loop(2000) do |connection|
  begin
    data = connection.read_nonblock(1024)
    puts data

    # We get this when there's no data to read
  rescue Errno::EAGAIN => error
    puts "\r\n#{error.class}\r\n\r\n"

    # waits until data is ready to be read
    IO.select([connection])
    retry
  rescue EOFError
    break
  end

  connection.close
end
