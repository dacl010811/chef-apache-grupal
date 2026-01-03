require 'spec_helper'

describe 'php::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04')
                        .converge(described_recipe)
  end

  # Test para la instalación de paquetes PHP
  it 'instala los paquetes PHP necesarios' do
    expect(chef_run).to install_package(%w[php php-mysql php-xml php-gd php-curl php-mbstring php-zip php-cli])
  end

  # Test para la instalación del paquete apache2 (dependencia)
  it 'instala el paquete apache2 como dependencia' do
    expect(chef_run).to install_package('apache2')
  end

  # Test para el servicio apache2
  it 'configura el servicio apache2' do
    expect(chef_run).to_not notify_service('apache2').to(:restart)
  end

  # Test para habilitar el módulo PHP en Apache
  it 'habilita el módulo PHP en Apache' do
    expect(chef_run).to run_execute('enable_php_module')
  end
end