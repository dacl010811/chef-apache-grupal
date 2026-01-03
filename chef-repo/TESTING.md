# Pruebas para el proyecto chef-apache-grupal

Este documento explica cómo ejecutar las pruebas unitarias e integración para los cookbooks de este proyecto.

## Pruebas Unitarias

Las pruebas unitarias están escritas usando ChefSpec y RSpec para verificar que los recursos en los recipes se creen correctamente sin necesidad de provisionar una máquina real.

### Ejecutar todas las pruebas unitarias

```bash
# Desde el directorio chef-repo
bundle install
bundle exec rspec
```

### Ejecutar pruebas para un cookbook específico

```bash
# Para probar solo el cookbook de Apache
bundle exec rake spec:apache

# Para probar solo el cookbook de MySQL
bundle exec rake spec:mysql

# Para probar solo el cookbook de PHP
bundle exec rake spec:php

# Para probar solo el cookbook de WordPress
bundle exec rake spec:wordpress
```

## Pruebas de Integración

Las pruebas de integración están escritas usando InSpec y Test Kitchen para verificar que los cookbooks funcionen correctamente cuando se ejecutan en una máquina real o virtual.

### Ejecutar pruebas de integración

```bash
# Listar los ambientes de prueba
kitchen list

# Probar un ambiente específico
kitchen converge default-ubuntu-2004
kitchen verify default-ubuntu-2004

# O probar todo en un solo paso
kitchen test
```

## Estructura de directorios

```
chef-repo/
├── Gemfile                 # Dependencias de Ruby
├── .rspec                  # Configuración de RSpec
├── spec_helper.rb          # Configuración común para pruebas
├── Rakefile               # Tareas para ejecutar pruebas
├── kitchen.yml            # Configuración de Test Kitchen
├── cookbooks/
│   ├── apache/
│   │   └── spec/          # Pruebas unitarias para Apache
│   ├── mysql/
│   │   └── spec/          # Pruebas unitarias para MySQL
│   ├── php/
│   │   └── spec/          # Pruebas unitarias para PHP
│   └── wordpress/
│       └── spec/          # Pruebas unitarias para WordPress
└── test/
    └── integration/       # Pruebas de integración
        └── default/
            ├── inspec.yml
            └── controls/  # Controles de verificación
```