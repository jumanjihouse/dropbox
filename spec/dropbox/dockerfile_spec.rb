# encoding: utf-8
require 'spec_helper'

describe 'jumanjiman/dropbox' do
  before :all do
    key, repo = 'RepoTags', 'jumanjiman/dropbox:latest'
    @image = Docker::Image.all.find { |i| i.info[key].include?(repo) }
    pp Docker::Image.all unless @image
  end

  before :each do
    @config = @image.json['config']
  end

  it 'image should be available' do
    @image.should_not be_nil
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
