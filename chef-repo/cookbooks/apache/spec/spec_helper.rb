# spec/spec_helper.rb

# 1. Carga la gema ChefSpec para habilitar los matchers (ej. install_package)
require 'chefspec'
require 'chefspec/policyfile' # Requerido si usas Policyfiles (estándar en 2026)

RSpec.configure do |config|
  # 2. Configura el nivel de log para que las pruebas no llenen la pantalla de avisos de Chef
  config.log_level = :error

  # 3. Formato de salida (opcional, ayuda a leer mejor los resultados)
  config.color = true
  config.formatter = :documentation
end
