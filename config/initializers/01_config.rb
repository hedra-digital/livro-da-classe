CONFIG = YAML.load_file(File.expand_path('../../config.yml', __FILE__)).with_indifferent_access
CONFIG.merge! CONFIG.fetch(Rails.env, {})
