class CouchConsole
  def init
    puts "** initialize update"
    @commands << {
      :regexp => /^\s*update\s*([^\s]*)\s*([^\s=]*)\s*=\s*([^\s]*)\s*$/,
      :method => :update,
      :documentation => [["update id field = value", "Update the field with value in document id"]]
    }
  end
  
  def update( id, field, value )
    document = @db.get( id )
    if document.class == CouchRest::Document
      document[field] = value
      begin
        document.save
        puts "*** Update `#{id}' : #{field} = #{value}"
      rescue => e
        puts "!!! Update `#{id}' faild with message #{e.message}"
      end
    else
      puts "!!! Can't update `#{id}'"
    end
  rescue RestClient::ResourceNotFound
    puts "!!! Document `#{id}' does not exist."
  end
end