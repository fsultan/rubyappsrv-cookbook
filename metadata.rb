name             'rubywebserv'
maintainer       'Fahd Sultan'
maintainer_email 'fahdsultan@gmail.com'
license           'Apache 2.0'
description      'Installs/Configures rubywebserv'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ debian }.each do |os|
  supports os
end

#depends "serv"
depends "apt"
depends "rbenv", '~> 1.7.1'
depends "nginx"
