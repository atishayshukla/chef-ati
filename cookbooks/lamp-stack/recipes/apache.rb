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
