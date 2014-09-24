Motion-UNIXSocket [![Code Climate](https://codeclimate.com/github/mgartner/motion-unixsocket/badges/gpa.svg)](https://codeclimate.com/github/mgartner/motion-unixsocket) [![Gem Version](https://badge.fury.io/rb/motion-unixsocket.svg)](http://badge.fury.io/rb/motion-unixsocket)
=================

RubyMotion doesn't provide the convenient UNIXSocket class for interacting with
Unix domain sockets. Motion-UNIXSocket is a replacement for UNIXSocket built
on top of C's socket library and Objective-C's NSFileHandle.

Installation
------------

Add this to your Gemfile:

```
gem "motion-unixsocket", "~> 0.0.1"
```

Run bundle install:

```
$ bundle install
```

Usage
-----

You can communicate with Unix domain sockets synchronously by reading and
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

Support
-------

I've only tested this gem on OS X.

Status
------

This gem is very young and I'm sure there's some unknown bugs and gotchas. I'll try to fix any issues brought up, but pull requests for bug fixes, optimizations, and API changes are always welcome.

Ideally the UNIX::Socket class would inherit from IO. If anyone knows an example of IO being subclassed properly, please point me in the right direction.

Tests
-----

Writing tests for this was a bit tricky. I ended up using an MRI Ruby process to create a socket server. Each test spawns this simple Unix domain socket server which echos a message sent to it and then closes. The tests check that the value written to the socket via UNIX::Socket (RubyMotion version) is the same as the value read back.

I was unable to get the asynchronous version working in the tests, but it works fine in an application and in the REPL.

License
-------

MIT License
