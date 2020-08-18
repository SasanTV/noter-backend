#!/bin/bash

until psql $DATABASE_URL -c '\l'; do
    >&2 echo "Posgres is unavailable - sleeping."
done

python3 /noter-backend/noter_backend/manage.py makemigrations
python3 /noter-backend/noter_backend/manage.py migrate
python3 /noter-backend/noter_backend/manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'dontusethispassword')"
python3 /noter-backend/noter_backend/manage.py runserver 0.0.0.0:3001

exec "$@"
