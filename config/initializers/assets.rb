# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path


# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "fonts")
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "stylesheets")
Rails.application.config.assets.precompile += [ "styles/*",  "styles/flat/*","styles/futurico/*","styles/line/*","styles/minimal/*","styles/polaris/*","styles/square/*"]
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf )
Dir[Rails.root.join('app/controllers/*_controller.rb')].map { |path| (path.match(/(\w+)_controller.rb/); $1) }.each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js.coffee","#{controller}.coffee", "#{controller}.css"]
end
Rails.application.config.assets.precompile += %w( application_scriptedit.js application_s3upload.js )




