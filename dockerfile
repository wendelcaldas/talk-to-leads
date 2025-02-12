# Use uma imagem oficial do PHP como base
FROM php:8.1-fpm

# Instale dependências
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    git \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql

# Defina o diretório de trabalho
WORKDIR /var/www

# Copie o composer para a imagem
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copie os arquivos do projeto para a imagem
COPY . .

# Instale as dependências do PHP
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Exponha a porta 80
EXPOSE 80

# Defina o comando para iniciar o servidor web (com Nginx, por exemplo)
CMD ["php-fpm"]
