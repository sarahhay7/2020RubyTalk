require 'socket'

class Server
  attr_reader :socket_address, :socket_port

  def initialize(socket_address, socket_port)
    @socket_address = socket_address
    @socket_port = socket_port

    puts "Starting server on port #{socket_port}"
  end

  def run
    Socket.tcp_server_loop(
      socket_address,
      socket_port
    ) do |client_connection, addr|

      # open thread for each accepted connection
      Thread.start(client_connection) do |conn|
        conn.puts "Please type in your name to start chatting!"
        # ensure chat names are unique
        conn_name = (
          conn.gets.chomp + '_' + connected_clients.size.to_s
        ).to_sym

        puts(successful_connection_message(conn_name, conn))

        connected_clients[conn_name] = conn

        conn.puts(
          successful_connection_message(conn_name, conn),
          "Welcome to chat!"
        )

        establish_chatting(conn_name, conn)

        connected_clients.delete(conn_name)
        conn.close
      end
    end.join
  end

  private

  def connected_clients
    @connected_clients ||= {}
  end

  def successful_connection_message(username, connection)
    "Connection established successfully #{username} => #{connection}"
  end

  def establish_chatting(username, connection)
    while message = connection.gets do
      message = message&.chomp

      puts connected_clients

      connected_clients.keys.each do |client|
        connected_clients[client].puts(
          "#{username}: #{message}"
        )
      end
    end
  end
end

Server.new('0.0.0.0', 3000).run
