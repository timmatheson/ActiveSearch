##Active Search:
***
  Active Search gives you an easy way to add a search feature to any active record model. Just include the gem and call search on any ActiveRecord class passing the query string as a parameter.


##Overview:
***
  Adds a simple search class method to every class that inherits from ActiveRecord::Base.
  
##Setup:
    # config/environment.rb
    config.gem 'active_search'

##Examples: 
    # Simple search for a store with a zipcode of 92688
    Store.search('92688') #=> [<#Store id: 1, zipcode: '92688'>,<#Store id: 2, zipcode: '92688'>]

##Customization:
    # You can specify columns to ignore with the config block
    # All columns will be excluded from searching

    class Blog < ActiveRecord::Base
      active_search_config do |config|
        config.active_search_exclude_columns = [:id, :url]
      end
    end