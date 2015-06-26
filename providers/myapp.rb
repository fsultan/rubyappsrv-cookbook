#
# Cookbook Name:: rubywebserver
# Provider:: myapp
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

#use_inline_resources

def create_template(app_name, app_dir, deployment_env)
	template "#{node.nginx.dir}/sites-available/#{app_name}" do
	  cookbook new_resource.cookbook
	  variables({
	    hostname: node['hostname'],
	    log_dir: node.default['nginx']['log_dir'],
	    rails_env: deployment_env,
	    app_dir: app_dir
	  })
	  source new_resource.nginx_passenger_template
	  mode '0644'
	  owner node.nginx.user
	  group node.nginx.user
	end
end

action :add do
	create_template(
		new_resource.name, 
		new_resource.app_dir, 
		new_resource.deployment_env
	)
	nginx_site new_resource.name do
  		enable true
	end
end

action :remove do
	nginx_site new_resource.name do
  		enable false
	end 
	if ::File.exists?("#{node.nginx.dir}/sites-available/#{new_resource.name}")
		Chef::Log.info "Removing #{new_resource.name} from #{node.nginx.dir}/sites-available/"
		file "#{node.nginx.dir}/sites-available/#{new_resource.name}" do
		  action :delete
		end
	end
end
