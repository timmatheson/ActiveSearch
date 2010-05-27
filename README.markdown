##Active Search
***

##Overview:
***
  Adds a simple search class method to every class that inherits from ActiveRecord::Base.
  
##Setup
config/environment.rb
    config.gem 'active_search'

##Usage  
in your controller
    Blog.search('tims blog') #=> <Blog#Instance>


##Customization
you can specify columns to ignore with the config block

    class Blog < ActiveRecord::Base
      active_search_config do |config|
        config.active_search_exclude_columns = [:id, :url]
      end
    end