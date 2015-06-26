#
# Cookbook Name:: rubywebserv
# Recipe:: default
#
# Copyright (C) 2015 Fahd Sultan
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.default['sysctl']['params']['vm']['overcommit_memory'] = 1

node.default['rbenv']['rubies'] = ["#{node.rubywebserv.ruby.version}"]
node.default['rbenv']['global'] = node['rubywebserv']['ruby']['version'] 

ruby_path = "#{node.rbenv.root_path}/versions/#{node.rubywebserv.ruby.version}"

include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node['rubywebserv']['ruby']['version'] do
	ruby_version node['rubywebserv']['ruby']['version']
	global true
	action :install
end

# rbenv_execute 'rbenv global #{node.rubywebserv.ruby.version}' do
# 	ruby_version node['rubywebserv']['ruby']['version']
# 	command "rbenv global #{node.rubywebserv.ruby.version}"
# 	action :run
# 	returns 0
# end

rbenv_gem 'bundler' do
  ruby_version node['rubywebserv']['ruby']['version']
end

rbenv_gem 'passenger' do
  ruby_version node['rubywebserv']['ruby']['version']
  if node['rubywebserv']['passenger']['version']
  	version node['rubywebserv']['passenger']['version'] 
  end
end

