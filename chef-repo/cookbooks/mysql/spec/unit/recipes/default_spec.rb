require 'chefspec'

describe 'mysql::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  # Prueba 1: Verifica que el paquete mysql-server se instale
  it 'instala el paquete mysql-server' do
    expect(chef_run).to install_package('mysql-server')
  end

  # Prueba 2: Verifica que el servicio mysql se habilite e inicie
  it 'habilita e inicia el servicio mysql' do
    expect(chef_run).to enable_service('mysql')
    expect(chef_run).to start_service('mysql')
  end
end