require_relative 'secrets'
require_relative 'controller'
require_relative 'view'
require_relative 'podio_api'
require_relative 'parser'
require 'io/console'
require 'byebug'
require 'unirest'
require 'json'
require 'podio'


Controller.new(view: View, 
               podio_api: PodioApi,
               parser: Parser,
               client_id: ENV["client_id"],
               client_secret: ENV["client_secret"])