#
# Cookbook Name:: rubyappsrv
# Recipe:: _rbenv
#
# Copyright (C) 2015 Fahd Sultan
#
# All rights reserved - Do Not Redistribute
#

node.default['sysctl']['params']['vm']['overcommit_memory'] = 1

ruby_path = "#{node.rbenv.root_path}/versions/#{node.rbenv.global}"
ruby_version = node['rubyappsrv']['ruby']['version']

include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

ENV['CONFIGURE_OPTS'] = '--disable-install-rdoc'

rbenv_ruby ruby_version do 
	ruby_version ruby_version
	global true
	action :install
end

rbenv_execute 'rbenv global #{ruby_version}' do
	ruby_version ruby_version
	command "rbenv global #{ruby_version}"
	action :run
	returns 0
end

rbenv_gem 'bundler' do
  ruby_version node['rubyappsrv']['ruby']['version']
end

