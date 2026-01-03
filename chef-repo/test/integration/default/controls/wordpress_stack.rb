# encoding: utf-8
# copyright: 2026, Chef Software, Inc.
# license: Apache-2.0

title 'Verificación del stack de WordPress'

# Verificar que Apache esté instalado y corriendo
control 'apache-01' do
  impact 1.0
  title 'Servicio Apache'
  desc 'Verifica que el servicio Apache esté instalado, habilitado y corriendo'
  
  describe package('apache2') do
    it { should be_installed }
  end
  
  describe service('apache2') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

# Verificar que MySQL esté instalado y corriendo
control 'mysql-01' do
  impact 1.0
  title 'Servicio MySQL'
  desc 'Verifica que el servicio MySQL esté instalado, habilitado y corriendo'
  
  describe package('mysql-server') do
    it { should be_installed }
  end
  
  describe service('mysql') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

# Verificar que PHP esté instalado
control 'php-01' do
  impact 1.0
  title 'Paquetes PHP'
  desc 'Verifica que los paquetes PHP necesarios estén instalados'
  
  %w[php php-mysql php-xml php-gd php-curl php-mbstring php-zip php-cli].each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end

# Verificar que WordPress esté instalado en el document root
control 'wordpress-01' do
  impact 1.0
  title 'Instalación de WordPress'
  desc 'Verifica que WordPress esté instalado correctamente'
  
  describe file('/vagrant/wp-config.php') do
    it { should exist }
    it { should be_owned_by 'www-data' }
  end
  
  describe file('/vagrant/index.php') do
    it { should exist }
  end
end