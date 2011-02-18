require "spec_helper.rb"
require 'net/ftp'

describe FakeFtp::Server do

  before :each do
    @directory = File.expand_path(__FILE__, "../../fixtures/destination")
    @text_filename = File.expand_path(__FILE__, "../../fixtures/text_file.txt")
  end

  after :each do
    FileUtils.rm_rf(@directory+"/*")
  end

  context 'setup' do
    it "starts a server on port n" do
      server = FakeFtp::Server.new(21212)
      server.port.should == 21212
    end

    it "should defaults to port 21" do
      server = FakeFtp::Server.new
      server.port.should == 21
    end

    it "should start and stop" do
      server = FakeFtp::Server.new(21212)
      server.is_running?.should be_false
      server.start
      server.is_running?.should be_true
      server.stop
      server.is_running?.should be_false
    end

    it "can be configured with a directory store" do
      server = FakeFtp::Server.new
      server.directory = @directory
      server.directory.should == @directory
    end

    it "should clean up directory after itself"

    it "should raise if attempting to delete a directory with contents other than its own"
  end

  context 'connection' do
    before :each do
      @server = FakeFtp::Server.new(21212)
      @server.start
    end

    after :each do
      @server.stop
    end
    
    it 'should accept ftp connections' do
      ftp = Net::FTP.new
      proc { ftp.connect('127.0.0.1', 21212) }.should_not raise_error
      proc { ftp.close }.should_not raise_error
    end

    it "should allow anonymous authentication"

    it "should allow named authentication"

    it "should put files to directory store"

  end

#  it "should authenticate" do
#    server = FakeFtp::Server.new(21212)
#    ftp = Net::FTP.new
#
#    proc { ftp.connect('127.0.0.1', 21212) }.should_not raise_error
#    proc { ftp.login('user', 'password') }.should_not raise_error(Net::FTPReplyError)
#
#    server.stop
#  end
#
#  context 'file puts' do
#    it "should accept a file" do
#      ftp = Net::FTP.new
#      ftp.connect('127.0.0.1', 21216)
#      proc { ftp.login('user', 'password') }.should_not raise_error
#      proc { ftp.put(@text_filename)}.should_not raise_error
#      Dir.glob(@directory).should include(@text_filename)
#    end
#  end
end