describe UNIX::Type do

  describe "#sizeof" do
    it "returns the size of a bool" do
      UNIX::Type.sizeof('B').should == 1
    end
    it "returns the size of an int" do
      UNIX::Type.sizeof('i').should == 4
    end
    it "returns the size of a sockaddr_un" do
      UNIX::Type.sizeof(Sockaddr_un.type).should == 106
    end
  end

end
