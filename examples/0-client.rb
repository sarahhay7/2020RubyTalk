require 'socket'

include Socket::Constants

client = Socket.new(AF_INET, SOCK_STREAM, 0)

host = "0.0.0.0"
port = 2000

socket_address = Socket.pack_sockaddr_in(port, host)

client.connect(socket_address)

# The above can be achieved with
# TCPSocket.new || TCPSocket.open || Socket.tcp

puts "Starting the client..."

while line = client.gets    # read lines from socket
  puts line.chomp           # print with record separator removed
end

puts "Closing the client..."

client.close # closes the socket
