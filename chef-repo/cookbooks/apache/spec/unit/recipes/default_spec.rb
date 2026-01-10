require 'chefspec'

describe 'apache::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04') do |node|
      # Mockeamos los datos de CPU y memoria que espera la receta facts
      node.automatic['memory']['total'] = '2048kB'
      node.automatic['cpu']['total'] = 2
      node.automatic['cpu']['0']['model_name'] = 'Intel Core i7'
    end.converge(described_recipe)
  end

  # Test 1: Apt Update
  it 'actualiza la caché de apt diariamente' do
    expect(chef_run).to periodic_apt_update('Update the apt cache daily')
  end

  # Test 2: Paquete Apache
  it 'instala el paquete apache2' do
    expect(chef_run).to install_package('apache2')
  end

  # Test 3: Servicio Apache (Acción)
  it 'define el servicio apache2 sin iniciarlo automáticamente' do
    expect(chef_run.service('apache2')).to do_nothing
  end

  # Test 4: Servicio Apache (Propiedades)
  it 'configura el servicio apache2 con soporte para status' do
    service = chef_run.service('apache2')
    expect(service.supports).to eq({ status: true })
  end

  # Test 5: Archivo por defecto
  it 'elimina el sitio por defecto de apache' do
    expect(chef_run).to delete_file('/etc/apache2/sites-enabled/000-default.conf')
  end
end