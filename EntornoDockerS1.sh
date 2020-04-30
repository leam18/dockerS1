#!/bin/bash

#Crea la imagen de Composer, instala las dependencias requeridas y luego borra el container
echo  "Creando imagen de composer e instalando dependencias..."
docker build -f DockerfileComposer . -t alpinecomposer:latest 2>&1 >/dev/null && docker run --rm -v $(pwd):/var/www alpinecomposer "composer install"  2>&1 >/dev/null
docker rmi alpinecomposer 2>&1 >/dev/null
echo  "Instaladas dependencias del proyecto"
#Cambia permisos para el user NO ROOT actual
sudo chown -R $USER:$USER $(pwd)
#Levanta docker-compose con php-fpm y nginx
echo  "Levantando entorno"
docker-compose up -d 2>&1 >/dev/null
echo  "Done"
