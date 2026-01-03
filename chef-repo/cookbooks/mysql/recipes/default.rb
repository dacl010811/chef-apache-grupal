# Instalar MySQL Server
package 'mysql-server' do
  action :install
end

# Asegurar que el servicio MySQL esté activo y habilitado
service 'mysql' do
  supports status: true, restart: true
  action [:enable, :start]
end

# Crear base de datos WordPress (idempotente)
execute 'create_wordpress_database' do
  command "sudo mysql -u root -e \"CREATE DATABASE #{node['wordpress']['db_name']};\""
  not_if  "sudo mysql -u root -e \"SHOW DATABASES LIKE '#{node['wordpress']['db_name']}';\" | grep #{node['wordpress']['db_name']}"
end

# Crear usuario WordPress (idempotente)
execute 'create_wordpress_user' do
  command "sudo mysql -u root -e \"CREATE USER '#{node['wordpress']['db_user']}'@'localhost' IDENTIFIED BY '#{node['wordpress']['db_password']}';\""
  not_if  "sudo mysql -u root -e \"SELECT user FROM mysql.user WHERE user='#{node['wordpress']['db_user']}';\" | grep #{node['wordpress']['db_user']}"
end

# Otorgar privilegios al usuario WordPress (idempotente)
execute 'grant_wordpress_privileges' do
  command "mysql -u root -e \"GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost'; FLUSH PRIVILEGES;\""
  not_if  "mysql -u root -e \"SHOW GRANTS FOR 'wordpress'@'localhost';\" | grep 'wordpress.*ALL PRIVILEGES'"
end
