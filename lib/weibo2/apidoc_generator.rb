# coding: utf-8
require 'mechanize'
require 'multi_json'
require 'fileutils'
require 'pathname'
require File.dirname(__FILE__) + '/config'

module Weibo2

  API_DOC_URI = 'http://open.weibo.com/wiki/API%E6%96%87%E6%A1%A3_V2#.E5.BE.AE.E5.8D.9A'

  module APIDocGenerator
    HEADERS = {
      'Accept-Encoding' => 'gzip',
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11'
    }

    def self.get_api_doc!
      agent = Mechanize.new
      agent.user_agent = HEADERS['User-Agent']
      page = agent.get(API_DOC_URI)
      api_doc = page.search('.wiki_table tr').map do |node|
        a = node.at 'td a' 

        if a
          hsh = {
            url: a.text,
            desc: (a.parent.next.next.text.strip rescue nil)
          }

          detail_page = agent.get(a['href'])
          format_node = detail_page.at('//*[@id=".E6.94.AF.E6.8C.81.E6.A0.BC.E5.BC.8F"]')
          if format_node
            hsh[:format] = format_node.parent.next.next.text.strip.downcase rescue nil
          end

          verb_node = detail_page.at('//*[@id="HTTP.E8.AF.B7.E6.B1.82.E6.96.B9.E5.BC.8F"]')
          if verb_node
            hsh[:http_verb] = verb_node.parent.next.next.text.strip.upcase rescue nil
          end

          print '.'

          hsh
        end
      end.compact

      puts
      print 'Writing file api_doc.json...'

      api_doc_file = Config::API_DOC_FILE
      if File.exists?(api_doc_file)
        FileUtils.mv api_doc_file, api_doc_file + '.bak'
      end

      File.open(api_doc_file, 'w') do |f|
        f.write MultiJson.encode(api_doc_file)
      end

      puts 'done'
    end


  end
end
