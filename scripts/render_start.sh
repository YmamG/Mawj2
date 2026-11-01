#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

python manage.py migrate --noinput --settings=config.settings_production
exec gunicorn config.wsgi_production:application --bind "0.0.0.0:${PORT:-8000}" --workers "${WEB_CONCURRENCY:-2}" --timeout 120 --no-control-socket --access-logfile -
