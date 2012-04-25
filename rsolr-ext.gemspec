# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'rsolr-ext'

Gem::Specification.new do |s|
  s.name = %q{rsolr-ext}
  s.version = RSolr::Ext.version

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Mitchell", "James Davidson", "Chris Beer", "Jason Ronallo", "Eric Lindvall", "Andreas Kemkes"]
  s.date = %q{2011-06-08}
  s.description = %q{A query/response extension lib for RSolr}
  s.email = %q{goodieboy@gmail.com}
  s.homepage = %q{http://github.com/mwmitchell/rsolr-ext}
  s.summary = %q{A query/response extension lib for RSolr}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # rsolr-ext has in the past fallen behind rsolr, and the resulting incompatibilities broke
  # blacklight.  Locking the gem version to close off this vulnerability. 
  # See http://groups.google.com/group/blacklight-development/browse_thread/thread/10d256f20f0bbc8d/35a5120c50060579?fwc=1
  # Also, James has told us that Blacklight does not plan on developing on RSolr for the future.
  # They are going to write their own library for interfacing with SOLR.
  s.add_dependency 'rsolr', "1.0.7"
  s.add_development_dependency 'rake', '~> 0.9.2'
  s.add_development_dependency 'rdoc', '~> 3.9.4'
  s.add_development_dependency 'rspec', '~> 2.6.0'

  # Commenting out rcov gem to avoid this error:
=begin
  Installing rcov (1.0.0) with native extensions
   Gem::Installer::ExtensionBuildError: ERROR: Failed to build gem native extension.
  
        /home/da217/.rvm/rubies/ruby-1.9.3-p0/bin/ruby extconf.rb
**** Ruby 1.9 is not supported. Please switch to simplecov ****


Gem files will remain installed in /home/da217/.rvm/gems/ruby-1.9.3-p0/gems/rcov-1.0.0 for inspection.
Results logged to /home/da217/.rvm/gems/ruby-1.9.3-p0/gems/rcov-1.0.0/ext/rcovrt/gem_make.out
An error occured while installing rcov (1.0.0), and Bundler cannot continue.
Make sure that `gem install rcov -v '1.0.0'` succeeds before bundling.
=end
  # s.add_development_dependency 'rcov'
end

