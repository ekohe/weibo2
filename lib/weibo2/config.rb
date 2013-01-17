module Weibo2
  module Config

    API_DOC_FILE = File.dirname(__FILE__) + '/api_doc.json'
    API_DOC = (MultiJson.load(File.read(API_DOC_FILE), symbolize_keys: true) rescue nil)

    if API_DOC
      API_URL_HASH = API_DOC.group_by { |hsh| hsh[:url] }
    end
    
    def self.api_key=(val)
      @@api_key = val
    end
    
    def self.api_key
      @@api_key
    end
    
    def self.api_secret=(val)
      @@api_secret = val
    end
    
    def self.api_secret
      @@api_secret
    end
    
    def self.redirect_uri=(val)
      @@redirect_uri = val
    end
    
    def self.redirect_uri
      @@redirect_uri
    end
  end
end
