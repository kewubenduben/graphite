include_recipe 'apache2::mod_python'
include_recipe 'apache2::mod_headers'
include_recipe 'apache2::mod_ssl' if node['graphite']['ssl']['enabled']

# find graphite web interface users from the defined data bag
user_databag = node['graphite']['apache']['basic_auth']['users_databag'].to_sym
group = node['graphite']['apache']['basic_auth']['users_databag_group']
begin
  sysadmins = search(user_databag, "groups:#{group} NOT action:remove")
rescue Net::HTTPServerException
  Chef::Log.fatal("Could not find appropriate items in the \"#{node['graphite']['apache']['basic_auth']['users_databag']}\" databag.  Check to make sure the databag exists and if you have set the \"users_databag_group\" that users in that group exist")
  raise 'Could not find appropriate items in the "users" databag.  Check to make sure there is a users databag and if you have set the "users_databag_group" that users in that group exist'
end

directory File.dirname(node['graphite']['apache']['basic_auth']['file_path'])
template "#{node['graphite']['apache']['basic_auth']['file_path']}" do
  source "htpasswd.users.erb"
  owner node['graphite']['user_account']
  group node['graphite']['group_account']
  mode 00640
  variables(:sysadmins => sysadmins)
  only_if { node['graphite']['apache']['basic_auth']['enabled'] }
end

template "#{node['apache']['dir']}/sites-available/graphite" do
  source 'graphite-vhost.conf.erb'
  notifies :reload, 'service[apache2]'
end

apache_site 'graphite'

apache_site '000-default' do
  enable false
end
