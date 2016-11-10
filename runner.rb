require './secrets'
require './controller'
require './view'

Controller.new(view: View, 
               client_id: ENV["client_id"],
               client_secret: ENV["client_secret"])