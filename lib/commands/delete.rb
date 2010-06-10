class CouchConsole
  def init
    puts "** initialize delete"
    @commands << {
      :regexp => /^\s*delete\s*([^\s]*)\s*([^\s]*)\s*$/,
      :method => :delete,
      :documentation => [["delete id [field]", "Delete the document with id or the field in the document"]]
    }
  end
  
  def delete( id, field )
    document = @db.get( id )
    if field.size > 0
      document.delete(field)
      document.save
      puts "*** Field `#{field}' deleted in document `#{id}'"
    else
      if document.class == CouchRest::Document
        document.destroy
        puts "*** Document `#{id}' deleted"
      else
        puts "!!! Can't delete document `#{id}'"
      end
    end
  rescue RestClient::ResourceNotFound
    puts "!!! Document `#{id}' does not exist."
  end
end