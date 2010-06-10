class CouchConsole
  def init
    puts "** initialize create"
    @commands << {
      :regexp => /^\s*new_doc\s*$/,
      :method => :new_doc,
      :documentation => [["new_doc", "Create a new document"]]
    }
  end
  
  def new_doc
    document = CouchRest::Document.new
    document.database = @db
    document.save
    puts "** Document `#{document.id}' created!"
  end
end