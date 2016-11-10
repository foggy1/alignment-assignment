class Controller
  def initialize(args={})
    @view = args.fetch(:view)
    @client_id = args.fetch(:client_id)
    @client_secret = args.fetch(:client_secret)
    @podio = args.fetch(:podio)
    @parser = args.fetch(:parser)
    run
  end

  def run
    @username, @password = @view.welcome
    @access_token = @podio.get_token({client_id: @client_id,
                     client_secret: @client_secret,
                     username: @username,
                     password: @password})
    ugly_items = @podio.get_items(@access_token)
    @items = @parser.parse(ugly_items)
  end
end