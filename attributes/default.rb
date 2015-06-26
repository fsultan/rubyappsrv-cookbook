#
# Cookbook Name:: rubywebserv
# Attributes:: default
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

override['nginx']['version'] = '1.8.0'
override['nginx']['source']['version'] = '1.8.0'
override['nginx']['source']['checksum'] = '23cca1239990c818d8f6da118320c4979aadf5386deda691b1b7c2c96b9df3d5'
override['nginx']['source']['url'] = "http://nginx.org/download/nginx-1.8.0.tar.gz"

default['rubywebserv']['app_env'] = 'development'
default['rubywebserv']['ruby']['version'] = '2.2.2'
default['rubywebserv']['ruby']['gem']['version'] = '2.4.5'  #hack, fix
default['rubywebserv']['passenger']['version'] = '5.0.11'

