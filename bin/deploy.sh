#!/bin/bash

set -e

docker run -d --name db --restart=always postgres
docker run -d --pull --name infish_prod --restart=always -e RAILS_ENV=production --env-file .env --link db:db -p 80:8080 hodak/infish:prod
docker exec infish_prod bundle exec rake db:create db:migrate
