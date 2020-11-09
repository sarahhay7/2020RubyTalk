require 'socket'
require 'rack'
require 'rack/lobster'

app = Rack::Lobster.new

Socket.tcp_server_loop(2000) do |connection|
  Thread.new do
    request = connection.gets
    puts request

    method, full_path = request.split(' ')
    path, query = full_path.split('?')

    status, headers, body = app.call({
      'REQUEST_METHOD' => method,
      'PATH_INFO' => path,
      'QUERY_STRING' => query
    })

    # status line tells browser that
    # HTTP version is 1.1 and response code is 200
    connection.print "HTTP/1.1 #{status}\r\n"

    # print the headers
    headers.each do |key, value|
      connection.print "#{key}: #{value}\r\n"
    end

    # print a newline
    connection.print "\r\n"

    # print all the lines of the body
    body.each { |part| connection.print part }

    connection.close
  end
end
