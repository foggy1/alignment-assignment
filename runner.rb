require_relative 'secrets'
require_relative 'controller'
require_relative 'view'
require_relative 'podio'
require_relative 'parser'
require 'io/console'
require 'byebug'
require 'unirest'
require 'json'


Controller.new(view: View, 
               podio: Podio,
               parser: Parser,
               client_id: ENV["client_id"],
               client_secret: ENV["client_secret"])