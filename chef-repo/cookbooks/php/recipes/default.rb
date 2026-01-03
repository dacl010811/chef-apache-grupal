# Instalar PHP y módulos necesarios para WordPress
package %w[
  php
  php-mysql
  php-xml
  php-gd
  php-curl
  php-mbstring
  php-zip
  php-cli
] do
  action :install
end

# Asegurar que Apache está instalado (dependencia)
package 'apache2'

# Definir servicio Apache (solo se reinicia si hay cambios)
service 'apache2' do
  supports status: true, restart: true, reload: true
  action :nothing
end

# Habilitar módulo PHP en Apache (Ubuntu 22.04)
execute 'enable_php_module' do
  command 'a2enmod php8.1'
  not_if 'apache2ctl -M | grep php'
  notifies :restart, 'service[apache2]'
end
