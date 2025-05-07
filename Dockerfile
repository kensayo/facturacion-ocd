# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t app .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name app app

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
FROM docker.io/library/ruby:3.3.8 AS base

# Rails app lives here
WORKDIR /facturacion-ocd

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client nano && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

#RUN mkdir -p /rails/tmp/sockets /rails/tmp/pids /rails/log && \
#    chmod -R 775 /rails/tmp /rails/log && \
#    touch /rails/log/development.log && \
#    chmod 664 /rails/log/development.log

# Set production environment
ENV RAILS_ENV="development"
    #BUNDLE_PATH="/usr/local/bundle" \

RUN gem install bundler

# Throw-away build stage to reduce size of final image
# FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock ./

#RUN mkdir -p "${BUNDLE_PATH}" && \
#    chmod -R 777 "${BUNDLE_PATH}"

RUN bundle config set frozen false && \
    bundle install && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
# RUN bundle exec bootsnap precompile rails/ lib/




# Final stage for app image
# FROM base

# Copy built artifacts: gems, application
#COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
#COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
#RUN groupadd --system --gid 1000 rails && \
#    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
#    chown -R rails:rails db log storage tmp
#USER 1000:1000

# Entrypoint prepares the database.
ENTRYPOINT ["./docker-entrypoint.sh"]

# Start server via Thruster by default, this can be overwritten at runtime
# EXPOSE 80
# CMD ["./bin/thrust", "./bin/rails", "server"]
