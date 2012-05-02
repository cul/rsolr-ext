require File.join(File.dirname(__FILE__), 'mash') unless defined?(Mash)

unless Hash.respond_to?(:to_mash)
  class Hash
    def to_mash
      Mash.new(self)
    end
  end
end

$: << File.dirname(__FILE__) unless $:.include?(File.dirname(__FILE__))
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'rubygems'
require 'rsolr'

module RSolr::Ext
  
  autoload :Client, 'rsolr-ext/client.rb'
  autoload :Doc, 'rsolr-ext/doc.rb'
  autoload :Group, 'rsolr-ext/group.rb'
  autoload :Request, 'rsolr-ext/request.rb'
  autoload :Response, 'rsolr-ext/response.rb'
  autoload :Model, 'rsolr-ext/model.rb'
  
  def self.version
    @version ||= File.read(File.join(File.dirname(__FILE__), '..', 'VERSION'))
  end
  
  VERSION = self.version
  
  # modify the RSolr::Client (provides #find and #luke methods)
  RSolr::Client.class_eval do
    include RSolr::Ext::Client
  end
  
  def self.connect *args, &blk
    RSolr.connect *args, &blk
  end
  
end
