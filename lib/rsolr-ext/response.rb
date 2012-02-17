module RSolr::Ext::Response
  
  autoload :Docs, 'rsolr-ext/response/docs'
  autoload :Facets, 'rsolr-ext/response/facets'
  autoload :Groups, 'rsolr-ext/response/groups'
  autoload :Spelling, 'rsolr-ext/response/spelling'
  
  class Base < Mash
    
    attr :original_hash
    attr_reader :request_path, :request_params
    
    def initialize hash, handler, request_params
      super hash
      @original_hash = hash
      @request_path, @request_params = request_path, request_params
      
      # Handle two types of queries/result-sets -- "standard" and Result-Grouped
      # The SOLR response for these are very different in structure 
      if @original_hash[ 'response' ]
        @response_module    = Response
        @result_type_module = Docs
      elsif @original_hash[ 'grouped' ]
        @response_module    = GroupedResponse
        @result_type_module = Groups
      else
        # Should neve get here
      end
      
      extend @response_module
      extend @result_type_module
      extend Facets
      extend Spelling
    end
    
    def header
      self['responseHeader']
    end
    
    def rows
      params[:rows].to_i
    end
    
    def params
      (header and header['params']) ? header['params'] : request_params
    end
    
    def ok?
      (header and header['status']) ? header['status'] == 0 : nil
    end
    
    def method_missing *args, &blk
      self.original_hash.send *args, &blk
    end
  
  end
  
  module Response
    
    def response
      self[:response]
    end
    
    def total
      response[:numFound].to_s.to_i 
    end
    
    def start
      response[:start].to_s.to_i
    end
    
  end
  
  module GroupedResponse
    
    def group_field
      # There's only one entry in the :grouped hash and the key is the value of the group.field param  
      self[:grouped].keys[0]
    end
    
    def response
      self[:grouped]
    end
    
    def total
      response[group_field][:matches] 
    end
    
    def start
      # Result-Grouped response has 'start' for each doclist, but no start for the groups 
      # collection itself.  The SOLR request can be used to get the start value.
      params[:start]
    end
    
  end
  
  
end
