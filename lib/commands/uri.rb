class CouchConsole
  def init
    puts "** initialize uri"
    @commands << {
      :regexp => /^\s*uri\s*(.*)\s*$/,
      :method => :uri,
      :documentation => [["uri id", "Returns the CouchDB uri for the document"]]
    }
  end
  
  def uri( id )
    document = @db.get( id )
    puts document.uri
  rescue RestClient::ResourceNotFound
    puts "!!! Document `#{id}' does not exist."
  end
end