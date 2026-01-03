# frozen_string_literal: true
# Configuración para pruebas unitarias de Chef con Chef Workstation

# Asegurar que las gemas del Gemfile estén disponibles
begin
  require 'bundler/setup'
rescue LoadError
  # Si no se puede cargar bundler/setup, continuar sin él
  # Esto es útil cuando se usa chef exec
end

require 'chefspec'
require 'chefspec/berkshelf'

# Configuración predeterminada para ChefSpec
RSpec.configure do |config|
  config.cookbook_path = ['cookbooks']
  config.role_path = 'roles'
  config.environment_path = 'environments'
  config.data_bag_path = 'data_bags'
end

# Configuración predeterminada para pruebas
ChefSpec::Coverage.start!

# Configuración de plataforma y versión predeterminada
RSpec.shared_context 'default platform' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04')
                        .converge(described_recipe)
  end
end

# Añadir el contexto compartido a todos los specs
RSpec.configure do |config|
  config.include_context 'default platform'
end