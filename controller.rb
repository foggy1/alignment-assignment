class Controller
  def initialize(args={})
    @view = args.fetch(:view)
    @client_id = args.fetch(:client_id)
    @client_secret = args.fetch(:client_secret)
    @auth = args.fetch(:auth)
    run
  end

  def run
    @username, @password = @view.welcome
    @access_token = @auth.get_token({client_id: @client_id,
                     client_secret: @client_secret,
                     username: @username,
                     password: @password})
  end
end