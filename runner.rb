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


Controller.new(view: View, 
               podio: Podio,
               parser: Parser,
               meeting_app_1: 17172422,
               meeting_app_2: 17172424,
               client_id: ENV["client_id"],
               client_secret: ENV["client_secret"])