# Paquetes necesarios
package %w[wget tar curl]

# Descargar WordPress
execute 'download_wordpress' do
  command "wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz"
  creates "/tmp/wordpress.tar.gz"
  environment 'PATH' => '/usr/bin:/bin'
end

# Extraer WordPress
execute 'extract_wordpress' do
  command "tar -xzf /tmp/wordpress.tar.gz -C /tmp"
  creates "/tmp/wordpress"
  environment 'PATH' => '/usr/bin:/bin'
end

# Copiar WordPress al document root
execute 'copy_wordpress' do
  command "cp -r /tmp/wordpress/* #{node['wordpress']['document_root']}/"
  not_if { ::File.exist?("#{node['wordpress']['document_root']}/wp-settings.php") }
  environment 'PATH' => '/usr/bin:/bin'
end

# Crear wp-config.php desde template
template "#{node['wordpress']['document_root']}/wp-config.php" do
  source 'wp-config.php.erb'
  owner 'www-data'
  group 'www-data'
  mode '0644'
  notifies :restart, 'service[apache2]'
end

# Permisos correctos
execute 'set_wordpress_permissions' do
  command "chown -R www-data:www-data #{node['wordpress']['document_root']}"
  environment 'PATH' => '/usr/bin:/bin'
end

# Permisos wp-content
execute 'set_wp_content_permissions' do
  command "chmod -R 755 #{node['wordpress']['document_root']}/wp-content"
  environment 'PATH' => '/usr/bin:/bin'
end

# Instalar WP-CLI
remote_file '/usr/local/bin/wp' do
  source 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
  mode '0755'
end

log 'Debug: Checking WordPress installation' do
  message "Document root: #{node['wordpress']['document_root']}, Install file exists: #{::File.exist?("#{node['wordpress']['document_root']}/wp-admin/install.php")}"
  level :info
end

# Instalar WordPress automáticamente
execute 'wp_core_install' do
  cwd node['wordpress']['document_root']
  command "wp core install \
    --url='#{node['wordpress']['url']}' \
    --title='#{node['wordpress']['title']}' \
    --admin_user='#{node['wordpress']['admin_user']}' \
    --admin_password='#{node['wordpress']['admin_password']}' \
    --admin_email='#{node['wordpress']['admin_email']}' \
    --allow-root"
  not_if { ::File.exist?("#{node['wordpress']['document_root']}/wp-admin/install.php") == false }
  environment 'PATH' => '/usr/local/bin:/usr/bin:/bin'
end


# Crear post automático
execute 'create_post_naty' do
  cwd node['wordpress']['document_root']
  command "wp post create --post_title='Hola, es la actividad grupal 2,Nathy, faltan names' --post_content='Bienvenidos a nuestro blog automatizado con Chef y Vagrant.' --post_status=publish --allow-root --path='#{node['wordpress']['document_root']}'"
  not_if "wp post list --allow-root --path='#{node['wordpress']['document_root']}' | grep 'Hola, es la actividad grupal 2,Nathy, faltan names'"
  environment 'PATH' => '/usr/local/bin:/usr/bin:/bin'
end
