class ActiveRecord::Base
  cattr_accessor :active_search_ignore_columns
  
  @@active_search_ignore_columns = []
  
  def self.active_search(&block)
    yield self if block_given?
  end
  
  def self.search(search_term, options = {})
    options[:conditions] = process_search_term(search_term)
    find(:all, options)
  end
  
  def self.active_search_columns
    @@active_search_columns ||= (columns.map(&:name).map(&:to_sym) - active_search_ignore_columns.map!(&:to_sym))
  end
  
  private
  
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