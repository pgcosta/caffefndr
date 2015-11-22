yml_path = Rails.root.join 'config/foursquare.yml'
FOURSQUARE_SETITINGS = YAML.load_file(yml_path.to_s)[Rails.env]