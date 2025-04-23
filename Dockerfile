# Dockerfile
FROM ruby:3.3

# Instalar dependencias del sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential libpq-dev

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar Gemfile y Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar gems
RUN bundle install

# Copiar el resto del código
COPY . .

# Exponer el puerto para Rails
EXPOSE 3000

# Comando por defecto
CMD ["rails", "server", "-b", "0.0.0.0"]
