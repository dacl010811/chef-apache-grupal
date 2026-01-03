apt_update 'Update the apt cache daily' do
  frequency 86400
  action :periodic
end

package 'apache2'

service 'apache2' do
  supports status: true
  action :nothing
end

# Eliminar sitio por defecto de Apache
file '/etc/apache2/sites-enabled/000-default.conf' do
  action :delete
end

# VirtualHost personalizado
template '/etc/apache2/sites-available/vagrant.conf' do
  source 'virtual-hosts.conf.erb'
  variables(
    document_root: node['apache']['document_root']
  )
  notifies :restart, 'service[apache2]'
end

# Habilitar sitio
link '/etc/apache2/sites-enabled/vagrant.conf' do
  to '/etc/apache2/sites-available/vagrant.conf'
  notifies :restart, 'service[apache2]'
end

# Eliminar index.html para que cargue WordPress
file "#{node['apache']['document_root']}/index.html" do
  action :delete
  only_if { ::File.exist?('/etc/apache2/sites-enabled/vagrant.conf') }
  notifies :restart, 'service[apache2]'
end

include_recipe '::facts'


  