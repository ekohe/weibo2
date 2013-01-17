require 'weibo2/client'
require 'weibo2/config'
require 'weibo2/error'
require 'weibo2/strategy/auth_code.rb'
require 'weibo2/strategy/signed_request.rb'
require 'weibo2/interface/base'
require 'weibo2/interface/account'
require 'weibo2/interface/comments'
require 'weibo2/interface/favorites'
require 'weibo2/interface/friendships'
require 'weibo2/interface/register'
require 'weibo2/interface/search'
require 'weibo2/interface/statuses'
require 'weibo2/interface/suggestions'
require 'weibo2/interface/tags'
require 'weibo2/interface/trends'
require 'weibo2/interface/users'


module Weibo2
  class << self

    def help(str)
      regex = Regexp.new(str.split.map{ |s| Regexp.escape(s) }.join('.*'), 'i')

      puts Config::API_DOC.select { |hsh| hsh[:url] =~ regex }
    end
  end
end
