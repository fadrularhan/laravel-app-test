# Gunakan image PHP 8.1 dengan FPM
FROM php:8.1-fpm

# Install dependensi yang dibutuhkan oleh Laravel
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Set working directory
WORKDIR /var/www/html

# Copy composer.lock dan composer.json
COPY composer.lock composer.json /var/www/html/

# Install dependensi PHP dengan Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-scripts --no-autoloader

# Copy seluruh proyek ke dalam container
COPY . /var/www/html

# Generate autoload file dan atur permission
RUN composer dump-autoload
RUN chown -R www-data:www-data /var/www/html/storage

# Expose port 9000 dan jalankan PHP-FPM
EXPOSE 9000
CMD ["php-fpm"]
