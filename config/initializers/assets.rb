# config/initializers/assets.rb

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
#Rails.application.config.assets.paths << Rails.root.join("node_modules") # Si usas Yarn/Node
Rails.application.config.assets.precompile += %w( application.css )

# Precompile additional assets.
# asd.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# Si tienes otros directorios dentro de app/assets que contienen assets que quieres precompilar
# Por ejemplo, app/assets/stylesheets/custom/style.css
# Rails.application.config.assets.precompile << Rails.root.join("app/assets", "stylesheets", "custom")

# Si tienes archivos CSS o JS en subdirectorios y quieres referenciarlos directamente para precompilar:
# Rails.application.config.assets.precompile += %w( specific_page.css specific_script.js )

# Si tienes assets en directorios fuera de app/assets que Rails debería buscar:
# Rails.application.config.assets.paths << "#{Rails.root}/lib/assets"
# Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets"