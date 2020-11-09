require 'socket'

message = "Happy November 19th!!\r\n" * 1000

connection = TCPSocket.open('localhost', 2000)

begin
  loop do
    bytes = connection.write_nonblock(message)

    # how much was written vs size of the message
    break if bytes >= message.size

    puts message.slice!(0, bytes)

    IO.select([], [connection])
  end

# we get this if there is nothing to write
rescue Errno::EAGAIN => error
  puts "\r\n#{error.class}\r\n\r\n"

  # wait until data ready to write
  IO.select([], [connection])
  retry
end
