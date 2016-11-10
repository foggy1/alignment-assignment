require_relative 'secrets'
require_relative 'controller'
require_relative 'view'
require_relative 'auth'
require 'io/console'
require 'byebug'
require 'unirest'
require 'podio'


Controller.new(view: View, 
               auth: Authorization,
               client_id: ENV["client_id"],
               client_secret: ENV["client_secret"])