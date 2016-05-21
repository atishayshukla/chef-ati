#
# Cookbook Name:: lamp-stack
# Recipe:: default
#
# Copyright 2016, ATISHAY_COMPANY
#
# All rights reserved - Do Not Redistribute
#
execute "update-yum" do
	command "yum update -y"
	action :run
end

