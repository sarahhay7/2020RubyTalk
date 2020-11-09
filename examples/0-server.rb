require 'socket'

include Socket::Constants

# Socket(domain, type, protocol = optional argument)
# AF_INET == Socket::AF_INET
# SOCK_STREAM == Socket::SOCK_STREAM

server = Socket.new(AF_INET, SOCK_STREAM, 0)

host = "0.0.0.0" # all addresses on this machine
port = 2000

socket_address = Socket.pack_sockaddr_in(port, host)

server.bind(socket_address)

# The above can be achieved with
# TCPServer.open || TCPServer.new

# max number of pending connections the socket will tolerate
server.listen(2)

# connection is another socket instance
connection, addr_info = server.accept

newline = "\r\n"
connection.puts newline
connection.puts "Server says what?"
connection.puts newline

puts "Server fileno: #{server.fileno}"

puts "Connection class: #{connection.class}"

# different file descriptor from server socket
puts "Connection fileno: #{connection.fileno}"

# endpoint on the machine
puts "Local address: "
p connection.local_address

# same as addr_info
puts "Remote address: "
p connection.remote_address

connection.close
