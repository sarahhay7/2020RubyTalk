require 'socket'

puts "Starting the server.........."

port = 2000
server = TCPServer.new port # the server will listen on port 2000

loop do                       # make the server run forever
  client = server.accept      # establish client connection

  client.puts client.inspect  # send the socket information to the client
  puts client.inspect         # print the socket information

  client.puts "YO"            # send message to client

  5.times { |i| client.puts i ; sleep 1 }

  client.puts "time is #{Time.now}"

  client.close  # disconnect from client
end
