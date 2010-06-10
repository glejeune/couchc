require 'couchrest'
require 'readline'

class CouchConsole
  def initialize
    @commands = [
      {
        :regexp => /^\s*help\s*$/,
        :method => :help,
        :documentation => [["help", "Display this help"]]
      },
      {
        :regexp => /^\s*quit\s*$/,
        :method => nil,
        :documentation => [["quit", "Quit"]]
      }
    ]
    Dir.glob( File.join(File.dirname(File.expand_path(__FILE__)), "commands", "*.rb") ).each do |file|
      require file
      init
    end
  end
  
  def getDatabase
    print "Database URI : ";
    $stdin.readline.chomp
  end

  def help
    @commands.each do |command|
      command[:documentation].each do |cmd|
        printf "%-30s : %s\n", cmd[0], cmd[1]
      end
    end
  end

  def execute( cmd )
    executed = 0
    @commands.each do |command|
      if match = command[:regexp].match(cmd)
        executed += 1
        params = match.captures
        if params.size > 0
          self.send command[:method], *params
        else
          self.send command[:method]
        end
      end
    end
    if executed == 0
      puts "!!! Command unknown. Try help"
    end
  end

  def go
    base = ARGV[0] || getDatabase
    
    @db = CouchRest.database!( base )
    begin
      @db.info
    rescue Errno::ECONNREFUSED
      puts "!!! Can acces database #{@db}"
      return
    end

    prompt = ">> "
    while( true )
      cmd = Readline.readline(prompt, true)
      break if cmd.nil? or cmd.chomp == "quit"
      execute( cmd )
    end
    puts "\nBye! Bye !\n"
  end
  
  def self.go
    CouchConsole.new.go
  end
end