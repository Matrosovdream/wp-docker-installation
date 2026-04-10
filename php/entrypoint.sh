#!/bin/bash
# Start supercronic in the background
supercronic /etc/wp-cron.crontab &

# Start php-fpm in the foreground (main process)
exec php-fpm
