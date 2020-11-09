`ruby examples/x-client.rb`
`ruby examples/x-server.rb`

`telnet 0.0.0.0 2000`
`ctrl + ]` to exit

`telnet 0.0.0.0 2000`
> GET / HTTP/1.1
> [EMPTY LINE]

> Get /?flip=left HTTP/1.1
> [EMPTY LINE]

Navigate to `localhost:2000` in browser

To get my IP Address for the chat server:
`ipconfig getifaddr en0`

`telnet 0.0.0.0 3000`
