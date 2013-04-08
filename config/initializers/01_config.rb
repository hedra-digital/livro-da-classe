CONFIG = YAML.load_file(File.expand_path('../../config.yml', __FILE__))
CONFIG.merge! CONFIG.fetch(Rails.env, {})
CONFIG.symbolize_keys!
