class CouchConsole
  def init
    puts "** initialize all_documents"
    @commands << {
      :regexp => /documents|all_docs/,
      :method => :allDocuments,
      :documentation => [
        ["documents", "Show the document with id"],
        ["_all_docs", "Same as documents"]
      ]
    }
  end
  
  def allDocuments
    all = @db.documents
    puts "#{all["total_rows"]} documents :"
    all["rows"].each do |doc|
      puts "  #{doc["id"]}"
    end
  end
end