#
# Cookbook Name:: rubywebserv
# Recipe:: default
#
# Author:: Fahd Sultan (<fahdsultan@gmail.com>)
# Copyright (C) 2014 Fahd Sultan
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

deployment_env = node['rubywebserv']['app_env']

#node.default['rbenv']['rubies'] = ["#{node.rubywebserv.ruby.version}"]
#node.default['rbenv']['global'] = node['rubywebserv']['ruby']['version'] 

include_recipe 'rbenv::default'
ENV['CONFIGURE_OPTS'] = '--disable-install-rdoc'

node.default['nginx']['passenger']['version'] = node['rubywebserv']['passenger']['version']
node.default['nginx']['source']['modules'] = [
  'nginx::http_stub_status_module',
  'nginx::http_ssl_module',
  'nginx::http_gzip_static_module',
  'nginx::passenger'
]

ruby_path = "#{node.rbenv.root_path}/versions/#{node.rubywebserv.ruby.version}"
gem_version = '2.2.0'
#gem_version = node['rubywebserv']['ruby']['gem']['version'] 

node.default['nginx']['source']['passenger']['version'] = node['rubywebserv']['passenger']['version']
node.default['nginx']['passenger']['ruby'] = "#{ruby_path}/bin/ruby"
node.default['nginx']['passenger']['root'] = \
  "#{ruby_path}/lib/ruby/gems/#{gem_version}/gems/passenger-#{node.rubywebserv.passenger.version}"

#install passenger gem first, with rbenv

rbenv_gem 'passenger' do
  ruby_version node['rubywebserv']['ruby']['version']
  action     :install
  if node['rubywebserv']['passenger']['version']
    version node['rubywebserv']['passenger']['version']
  end
end

node.default['nginx']['source']['default_configure_flags'].push("--add-module=#{node['nginx']['passenger']['root']}/ext/nginx")

package "libcurl4-openssl-dev"

include_recipe 'nginx::source'

template "#{node['nginx']['dir']}/conf.d/passenger.conf" do
  source 'nginx_passenger.conf.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]', :delayed
end

# nginx_site 'default' creates a default site in conf.d/defaut.conf file is
# created overides sites in sites-enabled.d/
nginx_site 'default' do
  enable false
end

