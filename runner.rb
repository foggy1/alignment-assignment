require_relative 'secrets'
require_relative 'controller'
require_relative 'view'
require_relative 'podio'
require_relative 'parser'
require 'io/console'
require 'byebug'
require 'unirest'
require 'json'
require 'date'

# API keys loaded into ENV variables with respective names in file named secrets.rb
# ID's of the from and to meeting apps loaded in right here
Controller.new(view: View, 
               podio: Podio,
               parser: Parser,
               meeting_app_1: 17172422,
               meeting_app_2: 17172424,
               client_id: ENV["client_id"],
               client_secret: ENV["client_secret"])