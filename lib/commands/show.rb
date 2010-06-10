class CouchConsole
  def init
    puts "** initialize show"
    @commands << {
      :regexp => /^\s*show\s*(.*)\s*$/,
      :method => :show,
      :documentation => [["show id", "Show the document with id"]]
    }
  end
  
  def showDesign( doc )
    puts "!!! Show design is not yet implemented"
  end

  def showDocument( doc )
    size = 0
    doc.keys.each { |k| size = k.size if k.size > size}
    doc.each do |k, v|
      printf "%#{size}s : %s\n", k, v
    end
  end

  def show( id )
    document = @db.get( id )
    if document.class == CouchRest::Document
      showDocument( document )
    else
      showDesign( document )
    end
  rescue RestClient::ResourceNotFound
    puts "!!! Document `#{id}' does not exist."
  end
end