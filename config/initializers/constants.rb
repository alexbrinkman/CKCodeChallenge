path = File.join(Rails.root, "config/constants.yml")
RT_CONSTANTS = YAML.load(File.read(path))[Rails.env] || { api_key: '', base_uri: '', limit: 25, cache_length: 60 }
RT_CONSTANTS['callable_uri'] = "#{RT_CONSTANTS['base_uri']}?apikey=#{RT_CONSTANTS['api_key']}&limit=#{RT_CONSTANTS['limit']}"