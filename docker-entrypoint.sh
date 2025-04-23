#!/usr/bin/env bash
set -e

RAILS_ENV=${RAILS_ENV:-development}
echo "Running in $RAILS_ENV environment"

rm -f tmp/pids/server.pid
bundle install

# wait-for-it $DATABASE_HOST:$DATABASE_PORT -s -t 30 -- echo "DB start success"

if [ "$RAILS_ENV" = "development" ]; then
  bundle exec rails db:create
  bundle exec rails db:migrate
  bundle exec rails s -b 0.0.0.0 -p 3000
elif [ "$RAILS_ENV" = "test" ]; then
  bundle exec rails db:create
  bundle exec rails db:migrate
  bundle exec rspec
elif [ "$RAILS_ENV" = "production" ]; then
  bundle exec rails db:migrate
  bundle exec sidekiq -e production -C config/sidekiq.yml &
  bundle exec rails s -b 0.0.0.0 -p 80
else
  echo "Unknown RAILS_ENV=$RAILS_ENV"
  exit 1
fi
