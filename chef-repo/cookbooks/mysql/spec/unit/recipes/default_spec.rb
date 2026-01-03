require 'spec_helper'

describe 'mysql::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04')
                        .converge(described_recipe)
  end

  # Test para la instalación del paquete mysql-server
  it 'instala el paquete mysql-server' do
    expect(chef_run).to install_package('mysql-server')
  end

  # Test para el servicio mysql
  it 'habilita y inicia el servicio mysql' do
    expect(chef_run).to enable_service('mysql')
    expect(chef_run).to start_service('mysql')
  end

  # Test para la creación de la base de datos de WordPress
  it 'crea la base de datos de WordPress' do
    expect(chef_run).to run_execute('create_wordpress_database')
  end

  # Test para la creación del usuario de WordPress
  it 'crea el usuario de WordPress' do
    expect(chef_run).to run_execute('create_wordpress_user')
  end

  # Test para otorgar privilegios al usuario de WordPress
  it 'otorga privilegios al usuario de WordPress' do
    expect(chef_run).to run_execute('grant_wordpress_privileges')
  end
end