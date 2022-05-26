#!/bin/bash

set -e 

if [ "$ENV" = 'DEV' ]; then
	echo "Running Development Server" # start server for developer
	exec python "identicon.py"
elif [ "$ENV" = 'UNIT' ]; then
  echo "Running Unit Tests"
  exec python "tests.py"
else
	echo "Running Production Server" # Start server for operation
	exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/identicon.py \
		--callable app --stats 0.0.0.0:9191
fi

