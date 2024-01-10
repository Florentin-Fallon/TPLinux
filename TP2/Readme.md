# TP2 : Utilisation courante de Docker
# I. Commun à tous : PHP
# 0. Setup
# ➜ Installer Docker sur votre PC
# I. Packaging de l'app PHP
# 🌞 docker-compose.yml

```shell
florentinfallon@MacBook-Pro-de-Florentin PHP % docker-compose up --build
[+] Running 11/1
 ✔ mysql 10 layers [⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]      0B/0B      Pulled                                                                                                                        11.9s 
[+] Building 0.6s (11/11) FINISHED                                                                                                                             docker:desktop-linux
 => [php-apache internal] load build definition from Dockerfile                                                                                                                0.0s
 => => transferring dockerfile: 500B                                                                                                                                           0.0s
 => [php-apache internal] load .dockerignore                                                                                                                                   0.0s
 => => transferring context: 2B                                                                                                                                                0.0s
 => [php-apache internal] load metadata for docker.io/library/php:8.2-apache                                                                                                   0.5s
 => [php-apache 1/6] FROM docker.io/library/php:8.2-apache@sha256:ef2fe60ad28191a96574edd0ce0fdf1638b676c8748dac60cd32c027b322eab2                                             0.0s
 => [php-apache internal] load build context                                                                                                                                   0.0s
 => => transferring context: 58B                                                                                                                                               0.0s
 => CACHED [php-apache 2/6] RUN docker-php-ext-install pdo_mysql                                                                                                               0.0s
 => CACHED [php-apache 3/6] RUN a2enmod rewrite                                                                                                                                0.0s
 => CACHED [php-apache 4/6] RUN chown -R www-data:www-data /var/www/html                                                                                                       0.0s
 => CACHED [php-apache 5/6] RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf                                                                                       0.0s
 => CACHED [php-apache 6/6] COPY src/ /var/www/html/                                                                                                                           0.0s
 => [php-apache] exporting to image                                                                                                                                            0.0s
 => => exporting layers                                                                                                                                                        0.0s
 => => writing image sha256:813358da3e5c112050c990650d378f79e88c94d507a404c35cf86fde06fb265d                                                                                   0.0s
 => => naming to docker.io/library/php-php-apache                                                                                                                              0.0s
[+] Running 2/2
 ✔ Container php-mysql-1       Created                                                                                                                                         0.7s 
 ✔ Container php-php-apache-1  Created                                                                                                                                         0.0s 
Attaching to mysql-1, php-apache-1
mysql-1       | 2024-01-10 14:47:41+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.2.0-1.el8 started.
php-apache-1  | [Wed Jan 10 14:47:41.704866 2024] [mpm_prefork:notice] [pid 1] AH00163: Apache/2.4.57 (Debian) PHP/8.2.14 configured -- resuming normal operations
php-apache-1  | [Wed Jan 10 14:47:41.704906 2024] [core:notice] [pid 1] AH00094: Command line: 'apache2 -D FOREGROUND'
mysql-1       | 2024-01-10 14:47:41+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
mysql-1       | 2024-01-10 14:47:41+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.2.0-1.el8 started.
mysql-1       | 2024-01-10 14:47:41+00:00 [Note] [Entrypoint]: Initializing database files
mysql-1       | 2024-01-10T14:47:41.979201Z 0 [System] [MY-015017] [Server] MySQL Server Initialization - start.
mysql-1       | 2024-01-10T14:47:41.980690Z 0 [Warning] [MY-011068] [Server] The syntax '--skip-host-cache' is deprecated and will be removed in a future release. Please use SET GLOBAL host_cache_size=0 instead.
mysql-1       | 2024-01-10T14:47:41.980752Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.2.0) initializing of server in progress as process 80
mysql-1       | 2024-01-10T14:47:41.988551Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
mysql-1       | 2024-01-10T14:47:42.275230Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
mysql-1       | 2024-01-10T14:47:43.233474Z 0 [ERROR] [MY-013129] [Server] A message intended for a client cannot be sent there as no client-session is attached. Therefore, we're sending the information to the error-log instead: MY-000029 - File '/docker-entrypoint-initdb.d/seed.sql' not found (OS errno 2 - No such file or directory)
mysql-1       | 2024-01-10T14:47:43.233516Z 0 [ERROR] [MY-010455] [Server] Failed to open the bootstrap file /docker-entrypoint-initdb.d/seed.sql
mysql-1       | 2024-01-10T14:47:43.233531Z 0 [ERROR] [MY-013236] [Server] The designated data directory /var/lib/mysql/ is unusable. You can remove all files that the server added to it.
mysql-1       | 2024-01-10T14:47:43.233547Z 0 [ERROR] [MY-010119] [Server] Aborting
mysql-1       | 2024-01-10T14:47:44.658552Z 0 [System] [MY-010910] [Server] /usr/sbin/mysqld: Shutdown complete (mysqld 8.2.0)  MySQL Community Server - GPL.
mysql-1       | 2024-01-10T14:47:44.659330Z 0 [System] [MY-015018] [Server] MySQL Server Initialization - end.
mysql-1 exited with code 1
php-apache-1  | 192.168.65.1 - - [10/Jan/2024:14:47:54 +0000] "GET / HTTP/1.1" 200 441 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3 Safari/605.1.15"
php-apache-1  | 192.168.65.1 - - [10/Jan/2024:14:47:55 +0000] "GET / HTTP/1.1" 200 440 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3 Safari/605.1.15"
```

# TP2 admins : PHP stack
# I. Good practices
# 🌞 Limiter l'accès aux ressources

Voici le résultat :

```shell
florentinfallon@MacBook-Pro-de-Florentin PHP % docker-compose logs php-apache
php-apache-1  | [Wed Jan 10 14:34:58.944863 2024] [mpm_prefork:notice] [pid 1] AH00163: Apache/2.4.57 (Debian) PHP/8.2.14 configured -- resuming normal operations
CONTAINER ID   NAME               CPU %     MEM USAGE / LIMIT   MEM %     NET I/O       BLOCK I/O    PIDS
```

# 🌞 No root

Voici le résultat :

J'ai rajouter un ligne dans le fichier docker-compose-yml pour le user

```shell
florentinfallon@MacBook-Pro-de-Florentin PHP % docker exec -it php-php-apache-1 bash
florentin@ddb64a206955:/var/www/html$ whoami
florentin
florentin@ddb64a206955:/
```

# II. Reverse proxy buddy
# A. Simple HTTP setup
# 🌞 Adaptez le docker-compose.yml

Voici le résultat obtenue :

```

```
Fichier Hosts :

```shell
florentinfallon@MacBook-Pro-de-Florentin ~ % cat /etc/hosts
172.20.0.3 www.supersite.com
172.20.0.3 pma.supersite.com
```

# B. HTTPS auto-signé
# 🌞 HTTPS auto-signé



# C. HTTPS avec une CA maison
# 🌞 Générer une clé et un certificat de CA



# 🌞 Générer une clé et une demande de signature de certificat pour notre serveur web



# 🌞 Faire signer notre certificat par la clé de la CA




# 🌞 Ajustez la configuration NGINX



# 🌞 Prouvez avec un curl que vous accédez au site web




# 🌞 Ajouter le certificat de la CA dans votre navigateur