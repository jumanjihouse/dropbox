# encoding: utf-8
require 'spec_helper'

describe 'jumanjiman/dropbox' do
  it 'should use correct docker API version' do
    Docker.validate_version!.should be_truthy
  end

  it 'image should be available' do
    Docker::Image.exist?('jumanjiman/dropbox').should be_truthy
  end

  context 'image properties' do
    before(:each) do
      @config = Docker::Image.get('jumanjiman/dropbox').info['Config']
    end

    it 'should expose ftp port and only ftp port' do
      @config['ExposedPorts'].keys.should =~ ['21/tcp']
    end

    volumes = %w(
      /var/ftp/pub/uploads
    )

    volumes.each do |vol|
      it "should have volume #{vol}" do
        @config['Volumes'].keys.include?(vol).should be_truthy
      end
    end
  end
end
