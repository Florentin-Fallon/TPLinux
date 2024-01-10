# Utilisez l'image PHP avec Apache
FROM php:8.2-apache

# Installez les extensions nécessaires pour votre projet
RUN docker-php-ext-install pdo_mysql

# Configurez Apache avec les paramètres spécifiques à Symfony
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copiez votre code source dans le conteneur
COPY src/ /var/www/html/

# Ajoutez ces lignes pour créer un nouvel utilisateur et définir l'utilisateur par défaut
RUN groupadd -g 1000 florentin && \
    useradd -u 1000 -g florentin -m -s /bin/bash florentin

USER florentin

# Démarrez Apache
CMD ["apache2-foreground"]
