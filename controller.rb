class Controller
  def initialize(args={})
    @view = args.fetch(:view)
    @client_id = args.fetch(:client_id)
    @client_secret = args.fetch(:client_secret)
    @podio_api = args.fetch(:podio_api)
    @parser = args.fetch(:parser)
    @items = []
    run
  end

  def run
    @username, @password = @view.welcome
    @podio_api.auth({client_id: @client_id,
                     client_secret: @client_secret,
                     username: @username,
                     password: @password})
    ugly_items = @podio_api.get_items
    @items = @parser.parse(ugly_items)
    # @podio.post_tasks({items: @items,
    #                    token: @access_token})
  end
end