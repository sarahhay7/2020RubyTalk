require 'socket'

client = TCPSocket.new('localhost', 2000)

message = 'Happy November 19th!!' * 10_000

client.write message

client.close
