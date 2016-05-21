#
# Cookbook Name:: lamp-stack
# Recipe:: apache
# Description:: This will do the installation of apache2 httpd for centos 6
# Copyright 2016, ATISHAY_COMPANY
#
# All rights reserved - Do Not Redistribute
#
# Installing package httpd ( Apache 2 for centos )

package "httpd" do
	action :install
end

# Apache needs to be enabled and started on the boot

service "httpd" do
	action [:enable, :start]
end

# Virtual Hosts file

node["lamp-stack"]["sites"].each do |sitename, data|
	document_root = "/var/www/html/#{sitename}"
# To create directory lets use directory resource with permission and recursive properties to be set
 	
	directory document_root do
		mode "0755"
		recursive true
	end

	execute "enable-sites" do
		command "a2ensite #{sitename}"
		action :nothing
	end
	
	template "/etc/httpd/conf.d/#{sitename}.conf" do
	source "virtualhosts.erb"
	mode "0644"
	variables(
	 :document_root => document_root,
	 :port => data["port"],
	 :serveradmin => data["serveradmin"],
	 :servername => data["servername"]
	)
	notifies :run, "execute[enable-sites]"
	notifies :restart, "service[httpd]"
	end

directory "/var/www/html/#{sitename}/public_html" do
	action :create
end

directory "/var/www/html/#{sitename}/logs" do
	action :create
end



execute "enable-event" do
	command "a2enmod httpd.conf"
	action :nothin
end

cookbook_file "/etc/httpd/conf/httpd.conf" do
	source "httpd.conf"
	mode "0644"
	notifies :run, "execute[enable-event]"
end

# Alternatively keepalive can be changed here using sed command
# execute "keepalive" do
# command "sed -i 's/keepAlive on/keepAlive off/g' /etc/httpd/conf/httpd.conf
# action :run
# end
v
p
	mode "
end
