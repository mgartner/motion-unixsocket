# A UNIXSocket can interact as a client with Unix domain sockets.
module UNIX
  class Socket

    # Creates a new Unix socket connection.
    def initialize(path, &block)
      @path = path
      @addr = socket_addr(@path)
      @on_read = block
      connect
    end

    # Reads available data on the communication channel and returns it as an
    # NSData object. If no data is available, the method blocks.
    def read
      data = @handle.availableData
      return data
    end

    # Writes the given data to the socket.
    def write(data)
      @handle.writeData(data)
    end

    # Closes the socket connection.
    def close
      @handle.closeFile
      @handle = nil
    end

    # Cleans up the socket.
    def dealloc
      notification_center.removeObserver(self)
      close
      super
    end

    private

    # Returns a pointer to a Sockaddr corresponding to the given path.
    def socket_addr(path)
      addr = Sockaddr_un.new
      addr.sun_family = AF_UNIX
      path.each_char.each_with_index do |c, i|
        addr.sun_path[i] = c
      end
      addr.sun_len = Type.sizeof(Sockaddr_un.type)
      addr_ptr = Pointer.new(Sockaddr_un.type, 1)
      addr_ptr[0] = addr
      addr_ptr.cast!(Sockaddr.type)
      return addr_ptr
    end

    # Connects to the socket.
    # When the socket is read from, the on_read callback will be called.
    def connect
      @sockfd = socket(AF_UNIX, SOCK_STREAM, 0)
      connect(@sockfd, @addr, @addr.value.sa_len)
      @handle = NSFileHandle.alloc.initWithFileDescriptor(@sockfd)

      if @on_read
        notification_center.addObserver(self, selector: "msg_received:",
                                        name: NSFileHandleReadCompletionNotification,
                                        object: @handle)
        @handle.readInBackgroundAndNotify
      end
    end

    # Called when an asynchronous message is received on the socket.
    # Passes the data on the communication channel to the block provided.
    def msg_received(notification)
      data = notification.userInfo.objectForKey(NSFileHandleNotificationDataItem)
      if data.length > 0
        NSLog("msg_received")
        @on_read.call(data)
      end
      @handle.readInBackgroundAndNotify
    end

    # Returns the default notification center.
    def notification_center
      NSNotificationCenter.defaultCenter
    end

  end
end
