module View
  # def self.test(test1, test2)
  #   p test1
  #   p test2
  # end
  def self.welcome
    puts "~~~~~~~~"
    puts "Welcome to Austin's Alignment Assignment!"
    puts "\n~~~~~~~~\n"
    self.get_info
  end

  def self.get_info
    print "Please enter your Podio username: "
    username = gets.chomp
    print "Please enter your Podio password: "
    password = STDIN.noecho(&:gets).chomp
    puts "~~~~~~~~"
    return [username, password]
  end
end