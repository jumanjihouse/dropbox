# encoding: utf-8
require 'spec_helper'

def docker_run(cmd = 'bash')
  IO.popen("docker run --rm -t jumanjiman/dropbox #{cmd}").readlines
end

describe 'users with interactive shells' do
  it 'should only include "root"' do
    # Which interactive shells are allowed in container?
    shells = docker_run('cat /etc/shells')
    shells.map!(&:chomp).reject! { |s| s.match %r{/sbin/nologin} }

    # Which users have an interactive shell?
    users = []
    records = docker_run('getent passwd')
    records.each do |r|
      fields = r.split(':')
      users << fields[0] if shells.include?(fields[6].chomp)
    end

    users.should =~ %w(root)
  end
end
