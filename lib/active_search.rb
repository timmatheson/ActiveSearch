class ActiveRecord::Base
  cattr_accessor :active_search_ignore_columns
   
  @@active_search_ignore_columns = []
  
  # Returns the current class, and allows you to
  # set any configuraiton options you would like.
  #
  # &block - the block of configuration code
  #
  # Example:
  #  active_search_config do |config|
  #    config.active_search_ignore_columns = [:id]
  #  end
  #
  # returns self
  def self.active_search_config(&block)
    yield self if block_given?
  end
  
  # Returns an Array of ActiveRecord objects matching the search term in one or more columns
  #
  # search_term - required, the search term to search for
  # options     - optional, accepts all ActiveRecord#find options, limit, offset, :joins, :include and more
  #
  # Example:
  #  Store.search('92688') #=> [<#Store id: 1, zipcode: '92688'>,<#Store id: 2, zipcode: '92688'>] 
  #
  # returns an Array of ActiveRecord objects matching the search term in one or more columns
  def self.search(search_term, options = {})
    options[:conditions] = process_search_term(search_term, sql_operand)
    find(:all, options)
  end
  
  # Returns an array of columns excluded by the search
  # This can be set using the ActiveRecord#active_search_config
  def self.active_search_columns
    @@active_search_columns ||= (columns.map(&:name).map(&:to_sym) - active_search_ignore_columns.map!(&:to_sym))
  end
  
  private
  
  # Maps the searchable columns to a string and handles String columns with LOWER
  # and all other columns without LOWER.
  #
  # Returns an array with the formatted query conditions
  def self.process_search_term(search_term)
    @@active_search_ignore_columns.map!(&:to_sym)
    query_conditions = columns.map do |ar_column|
      next unless active_search_columns.include?(ar_column.name.to_sym)
      if ar_column.type == :string
        " LOWER(#{ar_column.name.to_s}) like LOWER(?) "
      else
        "#{ar_column.name.to_s} = ?"
      end
    end.compact.join(" or ")
    [query_conditions, ( [ (search_term + '%') ] * active_search_columns.size ) ].flatten
  end
end