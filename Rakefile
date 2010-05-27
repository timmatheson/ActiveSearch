require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('active_search', '0.1.0') do |p|
  p.description              = "Adds simple searching to ActiveRecord Classes"
  p.url                      = "http://gitforked.com"
  p.author                   = "Tim Matheson"
  p.email                    = "me@timmatheson.com"
  p.ignore_pattern           = ["tmp/*","script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
