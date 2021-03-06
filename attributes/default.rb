#
# Cookbook Name:: graphite
# Attributes:: default
#

include_attribute 'apache2'

default['graphite']['version'] = '0.9.10'
default['graphite']['password'] = 'change_me'
default['graphite']['chef_role'] = 'graphite'
default['graphite']['url'] = 'graphite'
default['graphite']['url_aliases'] = []
default['graphite']['listen_port'] = 80
default['graphite']['base_dir'] = '/opt/graphite'
default['graphite']['doc_root'] = '/opt/graphite/webapp'
default['graphite']['storage_dir'] = '/opt/graphite/storage'
default['graphite']['timezone'] = 'America/Los_Angeles'
default['graphite']['django_root'] = '@DJANGO_ROOT@'

default['graphite']['whisper']['uri'] = "https://github.com/graphite-project/whisper/archive/#{node['graphite']['version']}.tar.gz"
default['graphite']['whisper']['checksum'] = '36b5fa917526224678da0a530a6f276d00074f0aa98acd6e2412c79521f9c4ff'

default['graphite']['carbon']['uri'] = "https://github.com/graphite-project/carbon/archive/#{node['graphite']['version']}.tar.gz"
default['graphite']['carbon']['checksum'] = '4f37e00595b5b078edb9b3f5cae318f752f4446a82623ea4da97dd7d0f6a5072'

default['graphite']['encrypted_data_bag']['name'] = nil

default['graphite']['graphite_web']['bitmap_support'] = true

#
# graphite_web
#

default['graphite']['web']['uri'] = "https://github.com/graphite-project/graphite-web/archive/#{node['graphite']['version']}.tar.gz"
default['graphite']['web']['checksum'] = '4fd1d16cac3980fddc09dbf0a72243c7ae32444903258e1b65e28428a48948be'
default['graphite']['web']['debug'] = 'False'
default['graphite']['web']['admin_email'] = 'admin@org.com'
default['graphite']['web']['cluster_servers'] = []
default['graphite']['web']['carbonlink_hosts'] = []
default['graphite']['web']['memcached_hosts'] = ['127.0.0.1:11211']
default['graphite']['web']['database']['NAME'] = node['graphite']['storage_dir']+"/graphite.db"
default['graphite']['web']['database']['ENGINE'] = "django.db.backends.sqlite3"
default['graphite']['web']['database']['USER'] = ""
default['graphite']['web']['database']['PASSWORD'] = ""
default['graphite']['web']['database']['HOST'] = ""
default['graphite']['web']['database']['PORT'] = ""
default['graphite']['web']['ldap']['SERVER'] = ""
default['graphite']['web']['ldap']['BASE_USER'] = ""
default['graphite']['web']['ldap']['BASE_PASS'] = ""
default['graphite']['web']['ldap']['USER_QUERY'] = "(sAMAccountName=%s)"
default['graphite']['web']['ldap']['SEARCH_BASE'] = ""
default['graphite']['web']['email']['BACKEND'] = "django.core.mail.backends.smtp.EmailBackend"
default['graphite']['web']['email']['HOST'] = "localhost"
default['graphite']['web']['email']['PORT'] = "25"
default['graphite']['web']['email']['HOST_USER'] = ""
default['graphite']['web']['email']['HOST_PASSWORD'] = ""
default['graphite']['web']['email']['USE_TLS'] = false
default['graphite']['web_server'] = 'apache'
default['graphite']['create_user'] = false

case node['graphite']['web_server']
when 'apache'
  default['graphite']['user_account'] = node['apache']['user']
  default['graphite']['group_account'] = node['apache']['group']
when 'uwsgi'
  default['graphite']['user_account'] = 'graphite'
  default['graphite']['group_account'] = 'graphite'
end

default['graphite']['ssl']['enabled'] = false
default['graphite']['ssl']['cipher_suite'] = 'ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP'
default['graphite']['ssl']['certificate_file'] = '/etc/ssl/server.crt'
default['graphite']['ssl']['certificate_key_file'] = '/etc/ssl/server.key'

default['graphite']['apache']['basic_auth']['enabled'] = false
default['graphite']['apache']['basic_auth']['file_path'] = "#{node['graphite']['doc_root']}/htpasswd"
default['graphite']['apache']['basic_auth']['users_databag'] = 'users'
default['graphite']['apache']['basic_auth']['users_databag_group'] = 'sysadmin'
