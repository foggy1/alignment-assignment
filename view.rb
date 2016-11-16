module View

  # Welcome new user.
  def self.welcome
    puts "~~~~~~~~"
    puts "Welcome to Austin's Alignment Assignment!"
    puts "~~~~~~~~\n"
    self.get_info
  end

  # Obtain and return user's Podio username and password (hidden)
  def self.get_info
    print "Please enter your Podio username: "
    username = gets.chomp
    print "Please enter your Podio password: "
    password = STDIN.noecho(&:gets).chomp
    puts "\n~~~~~~~~"
    return [username, password]
  end

  # Let user know if token was not retrieved due to incorrect username password.
  def self.invalid_login(error_message)
    puts "Could not obtain token. #{error_message}."
  end

  # Let user know the migration did nothing because it is already complete.
  def self.nothing_new
    puts "All items have already been copied over!"
  end

  # Let user know the program was a success and transferred things.
  def self.success(item_count)
    puts "#{item_count} item(s) successfully transferred!"
  end
  
end