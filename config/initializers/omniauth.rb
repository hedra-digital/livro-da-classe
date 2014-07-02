OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do 
  omni_auth_config = YAML.load_file(File.join(Rails.root, "config", "config.yml"))[Rails.env]["providers"]        
  omni_auth_config.each do |name, credentials|  
    provider name.to_sym, credentials["key"], credentials["secret"], {:client_options => omni_auth_config[:client_options]}         
  end  
end  
