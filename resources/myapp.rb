#
# Cookbook Name:: rubywebserver
# Resource:: myapp
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

actions :add, :remove
default_action :add if defined?(default_action) # Chef > 10.8

attribute :app_name, :kind_of => String, :name_attribute => true
#need the cookbook attribute to properly resolve template locations from within the LWRP
attribute :cookbook, :kind_of => String, :default => 'rubywebserv'
attribute :nginx_passenger_template, :kind_of => String, :default => 'myapp/nginx.passenger.erb'
attribute :deployment_env, :kind_of => String, :default => 'development'
attribute :app_dir, :kind_of => String
