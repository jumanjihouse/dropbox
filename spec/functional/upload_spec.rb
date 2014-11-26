# vim: set ts=2 sw=2 ai et:
require 'spec_helper'
require 'tempfile'

describe 'container' do
  before :all do
    @ip = `ip route get 8.8.8.8 | awk '/src/{print $NF}'`
    File.unlink('/tmp/README.md') if File.exist?('/tmp/README.md')
    `sudo useradd testuser`
  end

  after :all do
    File.unlink('/tmp/README.md') if File.exist?('/tmp/README.md')
  end

  # We start the container in spec/spec_helper.rb
  it 'should be available' do
    expect { Net::FTP.new(@ip) }.to_not raise_error
  end

  it 'should accept anonymous login' do
    ftp = Net::FTP.new(@ip)
    expect { ftp.login && ftp.quit }.to_not raise_error
  end

  it 'should deny directory listing' do
    ftp = Net::FTP.new(@ip)
    ftp.login
    expect { ftp.list }.to raise_error(Net::FTPPermError)
  end

  it 'should upload a file in binary mode' do
    ftp = Net::FTP.new(@ip)
    ftp.login
    ftp.chdir('uploads')
    ftp.putbinaryfile('README.md')
    ftp.quit

    local_md5sum = Digest::MD5.hexdigest(File.read('README.md'))
    remote_md5sum = Digest::MD5.hexdigest(File.read('/tmp/README.md'))

    local_md5sum.should eql remote_md5sum
  end

  it 'upload should be readable by testuser' do
    `sudo -u testuser cat /tmp/README.md`
    $CHILD_STATUS.exitstatus.should be_zero
  end
end
