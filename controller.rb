class Controller
  def initialize(args={})
    @view = args.fetch(:view)
    @client_id = args.fetch(:client_id)
    @client_secret = args.fetch(:client_secret)
    @podio = args.fetch(:podio)
    @parser = args.fetch(:parser)
    @meeting_app_1 = args.fetch(:meeting_app_1)
    @meeting_app_2 = args.fetch(:meeting_app_2)
    @items = []
    run
  end

  def run
    @username, @password = @view.welcome
    @access_token = @podio.get_token({client_id: @client_id,
                     client_secret: @client_secret,
                     username: @username,
                     password: @password})
    ugly_items = @podio.get_items(@access_token, @meeting_app_1)
    @items = @parser.parse(ugly_items)
    @new_items = @podio.reject_repeats(@access_token, @items, @meeting_app_2)
    @new_item_ids = @podio.make_items(@items.length, @new_items, @access_token)
    @view.nothing_new unless @new_item_ids
  end
end