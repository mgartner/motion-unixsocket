motion-unixsocket
=================

RubyMotion doesn't provide the convenient UNIXSocket class for interacting with
Unix domain sockets. Motion-UNIXSocket is a replacement for UNIXSocket built
on top of C's socket library and Objective-C's NSFileHandle.

Installation
------------

Add this to your Gemfile:

`gem "motion-unixsocket", "~> 0.0.1"`

Run bundle install:

`$ bundle install`

Usage
-----

You can communicate with Unix domain sockets synchronously by readin and
writing NSData objects.

```ruby
sock = UNIX::Socket.new('/path/to/socket')
msg = "Put a sock in it!\n"
sock.write(msg.to_data)

response = sock.read
puts NSString.stringWithUTF8String(response.bytes)
# => "Some message sent back."
```

You can read from the socket asynchronously by passing a block to the constructor.

```ruby
sock = UNIX::Socket.new('/path/to/socket') do |data|
  puts data # => prints and NSData object
end

msg = "Put a sock in it!\n"
sock.write(msg.to_data)
```

Status
------

This gem is very young and I'm sure there's some unknown bugs and gotchas. I'll try to fix any issues brought up, but pull requests for bug fixes, optimizations, and API changes are always welcome.

Ideally the UNIX::Socket class would inherit from IO, but when I tried to piece together what methods needed to be implemented to get the full features of IO, I nearly lost my mind. If anyone can point me in the right direction for this, please let me know.

License
-------

MIT License
