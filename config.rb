# Require any additional compass plugins here.
require 'compass-colors'
project_type = :stand_alone
# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "_site/stylesheets"
sass_dir = "_source/stylesheets"
extensions_dir = "_source/stylesheets/extensions"
images_dir = "_source/images"
http_images_path = "/images"
output_style = :nested
# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true
sass_options = { :cache_location => File.join(File.dirname(__FILE__), ".sass-cache")}
