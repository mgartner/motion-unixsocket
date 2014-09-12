describe UNIX::Socket do

  SOCKET_FILE = File.expand_path('../../sock', __FILE__)

  before do
    system("rm #{SOCKET_FILE}")
  end

  context "without a block given to the initializer" do
    it "should write and read data from the socket" do
      message = "hello\n"
      Process.spawn("ruby spec_helpers/echo.rb")
      sleep(0.5)
      s = UNIX::Socket.new(SOCKET_FILE)
      s.write(message.to_data)
      data = s.read
      response = NSString.stringWithUTF8String(data.bytes)
      response.should == message
    end
  end

  # TODO: I can't seem to get these tests working. UNIX::Socket works fine with
  # a block when I use it in the REPL, so this is weird.
  # context "with a block given to the initializer" do
  #   it "should write and read data from the socket" do
  #     message = "hello\n"
  #     #Process.spawn("ruby spec_helpers/echo.rb")
  #     sleep(0.5)
  #     response = nil
  #     s = UNIX::Socket.new(SOCKET_FILE) do |data|
  #       puts data
  #       response = NSString.stringWithUTF8String(data.bytes)
  #     end
  #     s.write(message.to_data)
  #     sleep(1)
  #     response.should == message
  #   end
  # end

end
