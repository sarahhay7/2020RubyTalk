require 'socket'

Socket.tcp_server_loop(2000) do |conn, client_addrinfo|
  Thread.new do
    ip_address = client_addrinfo.ip_address
    ip_port = client_addrinfo.ip_port

    client = "#{ip_address}:#{ip_port}"
    puts "#{client} is connected"

    conn.puts "The time is: #{Time.now.ctime}"

    begin
      loop do
        line = conn.readline
        puts "#{client} says: #{line}"

        # echoes input back to client
        conn.puts line
      end
    rescue EOFError
      conn.close
      puts "#{client} has disconnected"
    end
  end
end
