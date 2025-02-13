# Use uma imagem oficial do PHP como base (PHP 8.1)
FROM php:8.2-fpm

# Instale dependências para o PHP e extensões necessárias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    git \
    unzip \
    nginx \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql

# Defina o diretório de trabalho
WORKDIR /var/www

# Copie o composer para a imagem
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copie os arquivos do projeto para a imagem
COPY . .

# Instale as dependências do Laravel com o Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Copiar a configuração do Nginx
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Exponha as portas necessárias
EXPOSE 3000

# Comando para iniciar o Nginx e o PHP-FPM simultaneamente
CMD service nginx start && php-fpm
