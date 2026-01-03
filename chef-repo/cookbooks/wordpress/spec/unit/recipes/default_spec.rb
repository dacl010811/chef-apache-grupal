require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'wordpress::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04')
                        .converge(described_recipe)
  end

  # Test para la instalación de paquetes necesarios
  it 'instala paquetes necesarios' do
    expect(chef_run).to install_package(%w[wget tar curl])
  end

  # Test para descargar WordPress
  it 'descarga WordPress' do
    expect(chef_run).to run_execute('download_wordpress')
  end

  # Test para extraer WordPress
  it 'extrae WordPress' do
    expect(chef_run).to run_execute('extract_wordpress')
  end

  # Test para copiar WordPress al document root
  it 'copia WordPress al document root' do
    expect(chef_run).to run_execute('copy_wordpress')
  end

  # Test para crear wp-config.php
  it 'crea wp-config.php desde template' do
    expect(chef_run).to create_template('/vagrant/wp-config.php')
      .with(
        source: 'wp-config.php.erb',
        owner: 'www-data',
        group: 'www-data',
        mode: '0644'
      )
  end

  # Test para establecer permisos de WordPress
  it 'establece permisos correctos para WordPress' do
    expect(chef_run).to run_execute('set_wordpress_permissions')
  end

  # Test para establecer permisos de wp-content
  it 'establece permisos para wp-content' do
    expect(chef_run).to run_execute('set_wp_content_permissions')
  end

  # Test para instalar WP-CLI
  it 'instala WP-CLI' do
    expect(chef_run).to create_remote_file('/usr/local/bin/wp')
      .with(
        source: 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar',
        mode: '0755'
      )
  end

  # Test para la instalación de WordPress
  it 'instala WordPress automáticamente' do
    expect(chef_run).to run_execute('wp_core_install')
  end

  # Test para crear post automático
  it 'crea post automático' do
    expect(chef_run).to run_execute('create_post_naty')
  end
end