class CouchConsole
  def init
    puts "** initialize delete"
    @commands << {
      :regexp => /^\s*delete\s*(.*)\s*$/,
      :method => :delete,
      :documentation => [["delete id", "Delete the document with id"]]
    }
  end
  
  def delete( id )
    document = @db.get( id )
    if document.class == CouchRest::Document
      document.destroy
      puts "** Document `#{id}' deleted!"
    else
      puts "!!! Can't delete `#{id}'"
    end
  rescue RestClient::ResourceNotFound
    puts "!!! Document `#{id}' does not exist."
  end
end