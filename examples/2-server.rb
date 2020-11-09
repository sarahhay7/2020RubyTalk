require 'socket'

puts "Starting the server.........."

Socket.tcp_server_loop(2000) do |connection|
  Thread.new do
    connection.puts connection.inspect
    puts connection.inspect

    connection.puts "YO"

    5.times { |i| connection.puts i ; sleep 1 }

    connection.puts "time is #{Time.now}"

    connection.close
  end
end
