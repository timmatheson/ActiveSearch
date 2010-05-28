require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('active_search', '0.1.0') do |p|
  p.description              = "Active Search gives you an easy way to add a search feature to any active record model. Just include the gem and call search on any ActiveRecord class passing the query string as a parameter."
  p.url                      = "http://github.com/timmatheson/ActiveSearch"
  p.author                   = "Tim Matheson"
  p.email                    = "me@timmatheson.com"
  p.ignore_pattern           = ["tmp/*","script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
