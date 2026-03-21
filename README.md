# WP Docker Installation

Generic Docker setup for running a WordPress site backup or installer with:

- Nginx
- PHP-FPM 8.2
- MySQL 8
- VS Code Dev Container support

This project does **not** ship with WordPress files inside `app/`.
The `app/` folder is intentionally empty so you can place your own site files there.

## Folder structure

```text
wp-docker-installation/
├─ .devcontainer/
│  └─ devcontainer.json
├─ docker-compose.yml
├─ .env
├─ nginx/
│  └─ default.conf
├─ php/
│  ├─ Dockerfile
│  └─ uploads.ini
└─ app/
   └─ .gitkeep
```

## Important note about the app folder

`app/` is intentionally empty.

Put your project files there, for example:

- `installer.php`
- your backup archive
- `adminer.php`
- or a full existing WordPress codebase

Inside Docker this folder is mounted as:

```bash
/var/www/html
```

## Start the stack

From the project root:

```bash
docker compose up -d --build
```

Then open:

- Site / installer: `http://localhost:8080`
- Adminer (if you place `adminer.php` into `app/`): `http://localhost:8080/adminer.php`

## Database credentials

Default values come from `.env`:

```env
MYSQL_DATABASE=wordpress
MYSQL_USER=wordpress
MYSQL_PASSWORD=wordpress
MYSQL_ROOT_PASSWORD=root
```

When an installer asks for database access, use:

```text
Host: db
Database: wordpress
User: wordpress
Password: wordpress
```

Use `db` as the host, not `localhost`, because the database runs in a separate Docker container.

## Example: use with a Duplicator backup

1. Put these files into `app/`:
   - `installer.php`
   - backup archive
   - optionally `adminer.php`
2. Run:

```bash
docker compose up -d --build
```

3. Open:

```text
http://localhost:8080/installer.php
```

4. Use database settings:

```text
Host: db
Database: wordpress
User: wordpress
Password: wordpress
```

## VS Code / Claude workflow

You can open the project in VS Code and use the included Dev Container.

### Open in container

1. Open this folder in VS Code
2. Run `Dev Containers: Reopen in Container`

The PHP container becomes your dev environment.

### If you want Claude to work only on site files

Point Claude to the `app/` folder.

### If you want Claude to work on Docker config too

Point Claude to the whole project root.

## Useful commands

Stop containers:

```bash
docker compose down
```

Stop containers and delete database volume:

```bash
docker compose down -v
```

Show logs:

```bash
docker compose logs -f
```

Open a shell in PHP:

```bash
docker exec -it wp_docker_php bash
```

Open MySQL shell:

```bash
docker exec -it wp_docker_db mysql -u root -p
```

## File permissions after install

If needed:

```bash
docker exec -it wp_docker_php bash
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;
```
