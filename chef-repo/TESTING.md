# Pruebas para el proyecto chef-apache-grupal

Este documento explica cómo ejecutar las pruebas unitarias e integración para los cookbooks de este proyecto usando Chef Workstation.

## Pruebas Unitarias

Las pruebas unitarias están escritas usando ChefSpec y RSpec para verificar que los recursos en los recipes se creen correctamente sin necesidad de provisionar una máquina real.

### Ejecutar todas las pruebas unitarias

```bash
# Desde el directorio chef-repo
chef exec rake spec
```

### Ejecutar pruebas para un cookbook específico

```bash
# Para probar solo el cookbook de Apache
chef exec rake spec:apache

# Para probar solo el cookbook de MySQL
chef exec rake spec:mysql

# Para probar solo el cookbook de PHP
chef exec rake spec:php

# Para probar solo el cookbook de WordPress
chef exec rake spec:wordpress

# Para ejecutar todas las pruebas unitarias individualmente
chef exec rake spec:all
```

### Ejecutar pruebas unitarias directamente con chef exec

```bash
# Ejecutar pruebas directamente con chef exec
chef exec rspec cookbooks/apache/spec/unit/recipes/default_spec.rb
chef exec rspec cookbooks/mysql/spec/unit/recipes/default_spec.rb
chef exec rspec cookbooks/php/spec/unit/recipes/default_spec.rb
chef exec rspec cookbooks/wordpress/spec/unit/recipes/default_spec.rb
```

## Pruebas de Integración

Las pruebas de integración están escritas usando InSpec y Test Kitchen para verificar que los cookbooks funcionen correctamente cuando se ejecutan en una máquina real o virtual.

### Ejecutar pruebas de integración

```bash
# Listar los ambientes de prueba
chef exec kitchen list

# Probar un ambiente específico
chef exec kitchen converge default-ubuntu-2004
chef exec kitchen verify default-ubuntu-2004

# O probar todo en un solo paso
chef exec kitchen test

# Ejecutar todas las suites
chef exec kitchen test --concurrency=1
```

## Estructura de directorios

```
chef-repo/
├── Gemfile                 # Dependencias de Ruby
├── .rspec                  # Configuración de RSpec
├── spec_helper.rb          # Configuración común para pruebas
├── Rakefile               # Tareas para ejecutar pruebas con chef exec
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

## Comandos útiles

- `chef exec rake` - Ejecutar tareas Rake con el entorno de Chef
- `chef exec rspec` - Ejecutar pruebas RSpec con el entorno de Chef
- `chef exec kitchen` - Ejecutar comandos de Test Kitchen con el entorno de Chef
- `chef --version` - Verificar la versión de Chef Workstation instalada