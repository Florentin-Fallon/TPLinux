# TP1 : Premiers pas Docker
# 1. Installation de Docker
# 2. Vérifier que Docker est bien là

```shell
[florentinfallon@Patron ~]$ systemctl status docker
● docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; preset: disabled)
     Active: active (running) since Fri 2023-12-22 13:06:40 CET; 1min 7s ago
[florentinfallon@Patron ~]$ sudo systemctl start docker
[florentinfallon@Patron ~]$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
# 3. sudo c pa bo
# 🌞 Ajouter votre utilisateur au groupe docker

```shell
[florentinfallon@Patron ~]$ sudo usermod -aG docker florentinfallon
[florentinfallon@Patron ~]$ exit
logout
Connection to 192.168.29.11 closed.
florentinfallon@MacBook-Pro-de-Florentin ~ % ssh florentinfallon@192.168.29.11
florentinfallon@192.168.29.11's password: 
Activate the web console with: systemctl enable --now cockpit.socket
Last login: Fri Dec 22 12:44:39 2023 from 192.168.29.1
[florentinfallon@Patron ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

# 4. Un premier conteneur en vif
# 🌞 Lancer un conteneur NGINX

```shell
[florentinfallon@Patron ~]$ docker run -d -p 9999:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
24e221e92a36: Pull complete 
58cc89079bd7: Pull complete 
3799b53049f3: Pull complete 
2a580edba2f4: Pull complete 
cfe7877ea167: Pull complete 
6f26751fc54b: Pull complete 
c98494bb3682: Pull complete 
Digest: sha256:2bdc49f2f8ae8d8dc50ed00f2ee56d00385c6f8bc8a8b320d0a294d9e3b49026
Status: Downloaded newer image for nginx:latest
339a6a5bfa74a121cfd12bb0352c3710388173d20a056b6708434806fbe5d169
```

# 🌞 Visitons

Voici les conteneurs en cours de fonctionnement :
```shell
[florentinfallon@Patron ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED              STATUS              PORTS                                   NAMES
339a6a5bfa74   nginx     "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:9999->80/tcp, :::9999->80/tcp   cool_lichterman
```

Voici les logs du contenur :
```shell
[florentinfallon@Patron ~]$ docker logs cool_lichterman
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/12/22 12:17:41 [notice] 1#1: using the "epoll" event method
2023/12/22 12:17:41 [notice] 1#1: nginx/1.25.3
2023/12/22 12:17:41 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14) 
2023/12/22 12:17:41 [notice] 1#1: OS: Linux 5.14.0-284.30.1.el9_2.aarch64
2023/12/22 12:17:41 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1073741816:1073741816
2023/12/22 12:17:41 [notice] 1#1: start worker processes
2023/12/22 12:17:41 [notice] 1#1: start worker process 29
2023/12/22 12:17:41 [notice] 1#1: start worker process 30
2023/12/22 12:17:41 [notice] 1#1: start worker process 31
2023/12/22 12:17:41 [notice] 1#1: start worker process 32
```

Voici les informations relatives via la commande ***docker inspect*** :
```shell
[florentinfallon@Patron ~]$ docker inspect cool_lichterman
[
    {
        "Id": "339a6a5bfa74a121cfd12bb0352c3710388173d20a056b6708434806fbe5d169",
        "Created": "2023-12-22T12:17:40.717388182Z",
        "Path": "/docker-entrypoint.sh",
        "Args": [
            "nginx",
            "-g",
            "daemon off;"
        ],
```

Voici le port en écoute :
```shell
LISTEN       0            4096                     0.0.0.0:9999                    0.0.0.0:*           users:(("docker-proxy",pid=57724,fd=4)) 
```

Voici l'ouverture du Port 9999 dans le firewall :
```shell
[florentinfallon@Patron ~]$ sudo firewall-cmd --add-port=9999/tcp --permanent
success
[florentinfallon@Patron ~]$ sudo firewall-cmd --reload
success
```

J'ai étais sur ***http://192.168.29.11:9999*** et j'ai bien eu ça :
```shell
Welcome to nginx!

If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to nginx.org.
Commercial support is available at nginx.com.

Thank you for using nginx.
```


# 🌞 On va ajouter un site Web au conteneur NGINX

Voici le index.html :
```shell
[florentinfallon@Patron nginx]$ cat index.html
<h1> Salut les boys ! </h1>
```

Voici le site_nul.conf :
```shell
[florentinfallon@Patron nginx]$ cat site_nul.conf
server {
	listen 8080;
	location / {
		root /var/www/html;
}
}
```

Voici le résulat lors du lancement de la commande : 
```shell
[florentinfallon@Patron nginx]$ docker run -d -p 9999:8080 -v /home/florentinfallon/nginx/index.html:/var/www/html/index.html -v /home/florentinfallon/nginx/site_nul.conf:/etc/nginx/conf.d/site_nul.conf nginx
64551a0eba8d279384ce692f902c5caa52549df2ae338e5f98f0b9249f70bb63
```
# 🌞 Visitons

Voici la vérification du conteneur actif :
```shell
[florentinfallon@Patron nginx]$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                               NAMES
64551a0eba8d   nginx     "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   80/tcp, 0.0.0.0:9999->8080/tcp, :::9999->8080/tcp   xenodochial_feynman
```

Voici le résultat lors de la visite du site web :
```shell
Salut les boys !
```

# 5. Un deuxième conteneur en vif
# 🌞 Lance un conteneur Python, avec un shell

Voici le lancement du conteneur :
```shell
[florentinfallon@Patron nginx]$ docker run -it python bash
Unable to find image 'python:latest' locally
latest: Pulling from library/python
b66b4ecd3ecf: Pull complete 
6c641d36985b: Pull complete 
ddd8544b6e15: Pull complete 
ae58c7c06d64: Pull complete 
f9f35f1c3178: Pull complete 
0d89c447e056: Pull complete 
9862771c91cc: Pull complete 
93aa698c30e4: Pull complete 
Digest: sha256:3733015cdd1bd7d9a0b9fe21a925b608de82131aa4f3d397e465a1fcb545d36f
Status: Downloaded newer image for python:latest
root@e420013bc32b:/# 
```

# 🌞 Installe des libs Python

Voici l'install ***aiohttp*** :
```shell
root@TPLinux-TP1:/# pip install aiohttp
Collecting aiohttp
Successfully built multidict
Installing collected packages: multidict, idna, frozenlist, attrs, yarl, aiosignal, aiohttp
Successfully installed aiohttp-3.9.1 aiosignal-1.3.1 attrs-23.1.0 frozenlist-1.4.1 idna-3.6 multidict-6.0.4 yarl-1.9.4
```

Voici l'install ***aioconsole*** :
```shell
root@TPLinux-TP1:/# pip install aioconsole
Collecting aioconsole
Installing collected packages: aioconsole
Successfully installed aioconsole-0.7.0
```

Voici le lancement de ***l'intérpréteur Python****, avec la commande ***import*** :
```shell
root@TPLinux-TP1:/# python
Python 3.12.1 (main, Dec 19 2023, 16:44:02) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import aiohttp
>>> 
```

# II. Images
# 1. Images publiques
# 🌞 Récupérez des images

Voici la récupération de l'image ***python:3.11*** :
```shell
[florentinfallon@Patron nginx]$ docker pull python:3.11
3.11: Pulling from library/python
b66b4ecd3ecf: Already exists 
6c641d36985b: Already exists 
ddd8544b6e15: Already exists 
ae58c7c06d64: Already exists 
f9f35f1c3178: Already exists 
46291213e1ef: Pull complete 
da3063c53684: Pull complete 
8ba1806ae141: Pull complete 
Digest: sha256:4e5e9b05dda9cf699084f20bb1d3463234446387fa0f7a45d90689c48e204c83
Status: Downloaded newer image for python:3.11
docker.io/library/python:3.11
```

Voici la récupération de l'image ***mysql*** :
```shell
[florentinfallon@Patron nginx]$ docker pull mysql
Using default tag: latest
latest: Pulling from library/mysql
f065eb68ef2e: Pull complete 
4347407baabc: Pull complete 
3ac2468bda24: Pull complete 
83f773ef2c87: Pull complete 
1dad2c7f0c6a: Pull complete 
808b6b0a452f: Pull complete 
1938c61da20f: Pull complete 
bd13b3b553e4: Pull complete 
a00ae17e153b: Pull complete 
29255c8a5cf0: Pull complete 
Digest: sha256:4ef30b2c11a3366d7bb9ad95c70c0782ae435df52d046553ed931621ea36ffa5
Status: Downloaded newer image for mysql:latest
docker.io/library/mysql:latest
```

Voici la récupération de l'image ***wordpress*** en dernière version:
```shell
[florentinfallon@Patron nginx]$ docker pull wordpress:latest
latest: Pulling from library/wordpress
24e221e92a36: Already exists 
a3e96785d20e: Pull complete 
938e1c871e05: Pull complete 
c628ed3e4c42: Pull complete 
42ba4aaa606d: Pull complete 
7aac66f1c9c7: Pull complete 
ef8425f87af5: Pull complete 
8339afd62c06: Pull complete 
f7c14b8798b7: Pull complete 
f5e9ab140eea: Pull complete 
6baae164c2c4: Pull complete 
de793c5d0e2b: Pull complete 
5c4abe12acdd: Pull complete 
4e53a5edf04a: Pull complete 
6416a4348c0b: Pull complete 
b192fad588d6: Pull complete 
4c0f02046772: Pull complete 
013bb9b9d9a7: Pull complete 
475dfe0df238: Pull complete 
813a21f5e497: Pull complete 
c395f7be4ab5: Pull complete 
Digest: sha256:ffabdfe91eefc08f9675fe0e0073b2ebffa8a62264358820bcf7319b6dc09611
Status: Downloaded newer image for wordpress:latest
docker.io/library/wordpress:latest
```

Voici la récupération de l'image ***linuxserver/wikijs*** :
```shell
[florentinfallon@Patron nginx]$ docker pull linuxserver/wikijs
Using default tag: latest
latest: Pulling from linuxserver/wikijs
e03d91f524e7: Pull complete 
07a0e16f7be1: Pull complete 
24b296671cef: Pull complete 
332c019da471: Pull complete 
a3c9e8b6dce0: Pull complete 
030507257325: Pull complete 
1f9aa5cff2b1: Pull complete 
Digest: sha256:131d247ab257cc3de56232b75917d6f4e24e07c461c9481b0e7072ae8eba3071
Status: Downloaded newer image for linuxserver/wikijs:latest
docker.io/linuxserver/wikijs:latest
```

Voici le récapitulatif des images dowload avec docker pull :
```shell
[florentinfallon@Patron nginx]$ docker image ls
REPOSITORY           TAG       IMAGE ID       CREATED        SIZE
mysql                latest    8e409b83ace6   3 days ago     641MB
linuxserver/wikijs   latest    772abe6ffca7   7 days ago     459MB
ubuntu               latest    da935f064913   10 days ago    69.3MB
python               3         b3148b8eb04d   2 weeks ago    1.02GB
python               latest    b3148b8eb04d   2 weeks ago    1.02GB
wordpress            latest    4468dc043c37   2 weeks ago    739MB
python               3.11      f983f601e9a2   2 weeks ago    1.01GB
nginx                latest    8aea65d81da2   8 weeks ago    192MB
python               3.8       e676f34aeb2c   2 months ago   1GB
```

# 🌞 Lancez un conteneur à partir de l'image ***Python***

Voici le résultat aprés le lancement du conteneur python :
```shell
[florentinfallon@Patron nginx]$ docker run -it --name python-container python:3.11 bash
root@36e8341f138d:/# python --version
Python 3.11.7
```

# 2. Construire une image
# 🌞 Ecrire un Dockerfile pour une image qui héberge une application Python

Voici la création du dossier plus les deux fichiers :
```shell
[florentinfallon@Patron python_app_build]$ ls
Dockerfile  app.py
[florentinfallon@Patron python_app_build]$ cat app.py
import emoji

print(emoji.emojize("Cet exemple d'application est vraiment naze :thumbs_down:"))

[florentinfallon@Patron python_app_build]$ cat Dockerfile 
# Utilisez l'image de base Debian
FROM debian:latest

# Mettez à jour la liste des paquets
RUN apt update

# Installez Python
RUN apt install -y python3

# Installez la librairie Python emoji
RUN pip install emoji

# Ajoutez l'application
COPY app.py /app.py

# Définissez le répertoire de travail
WORKDIR /app.py

# Commande d'entrée pour lancer l'application
ENTRYPOINT ["python3", "/app.py"]
```

# 🌞 Build l'image



# 🌞 Lancer l'image