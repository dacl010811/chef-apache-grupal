require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.cookbook_path = ['../../..']
  config.platform = 'ubuntu'
  config.version = '20.04'
end

describe 'apache::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04')
                        .converge(described_recipe)
  end

  # Test para apt_update
  it 'actualiza el cache de apt' do
    expect(chef_run).to run_apt_update('Update the apt cache daily')
      .with(frequency: 86_400)
  end

  # Test para la instalación del paquete apache2
  it 'instala el paquete apache2' do
    expect(chef_run).to install_package('apache2')
  end

  # Test para el servicio apache2
  it 'configura el servicio apache2' do
    expect(chef_run).to_not notify_service('apache2').to(:restart)
  end

  # Test para eliminar el sitio por defecto de Apache
  it 'elimina el sitio por defecto de Apache' do
    expect(chef_run).to delete_file('/etc/apache2/sites-enabled/000-default.conf')
  end

  # Test para el template de virtual host
  it 'crea el template de virtual host' do
    expect(chef_run).to create_template('/etc/apache2/sites-available/vagrant.conf')
      .with(
        source: 'virtual-hosts.conf.erb',
        variables: { document_root: '/vagrant' }
      )
  end

  # Test para habilitar el sitio
  it 'habilita el sitio de vagrant' do
    expect(chef_run).to create_link('/etc/apache2/sites-enabled/vagrant.conf')
      .with(to: '/etc/apache2/sites-available/vagrant.conf')
  end

  # Test para eliminar index.html
  it 'elimina index.html del document root' do
    expect(chef_run).to delete_file('/vagrant/index.html')
  end
end