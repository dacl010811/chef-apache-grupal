#!/bin/bash

sudo mkdir -p /vagrant

# chef-solo es una versión simplificada de Chef que no requiere un servidor Chef centralizado. Ejecuta recetas de configuración de manera local usando ficheros JSON y recetas locales.

#-c Indica el archivo de configuración (solo.rb) que chef-solo usará. Este archivo define cosas como la ubicación de las recetas, cachés, etc.
# -j Especifica un archivo JSON con los atributos del nodo y las recetas que deben ejecutarse. Este archivo define qué configuraciones deben aplicarse.

# En chef-repo/nodes/*.json se guardar los ::facts
sudo /opt/chef/bin/chef-solo -c solo.rb -j node.json -l info 