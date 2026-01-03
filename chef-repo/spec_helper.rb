# frozen_string_literal: true

require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.cookbook_path = ['cookbooks']
  config.platform = 'ubuntu'
  config.version = '20.04'
  
  # Configuración adicional para compatibilidad
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.disable_monkey_patching!
  config.warnings = true
  
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
  
  config.order = :random
  Kernel.srand config.seed
end