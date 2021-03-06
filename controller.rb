class Controller
  def initialize(args={})
    @view = args.fetch(:view)
    @client_id = args.fetch(:client_id)
    @client_secret = args.fetch(:client_secret)
    @podio = args.fetch(:podio)
    @parser = args.fetch(:parser)
    @meeting_app_1 = args.fetch(:meeting_app_1)
    @meeting_app_2 = args.fetch(:meeting_app_2)
    @app_ids = [args.fetch(:meeting_app_1), args.fetch(:meeting_app_2)]
    @items = []
    run
  end


  # Get username password.  Get token.  
  # Inform user and end program if invalid username or password is provided.
  # Get items from origin app and destination app.
  # Scrub all items, removing duplicates, and filtering by 'Date confirmed' status.
  # Make items from the difference between origin and destination app.
  # Inform user if nothing was made.
  def run
    @username, @password = @view.welcome
    @access_token = @podio.get_token(client_id: @client_id,
                     client_secret: @client_secret,
                     username: @username,
                     password: @password)
    return @view.invalid_login(@access_token["error_description"]) if @access_token["error"]
    ugly_items = @app_ids.map{ |app_id| @podio.get_items(@access_token, app_id) }
    @app_one_items, @app_two_items = ugly_items.map { |scrubable| @parser.parse(scrubable) }
    @new_item_ids = @podio.make_items(count: @app_one_items.length, 
                                      items: @app_one_items - @app_two_items, 
                                      token: @access_token)
    return @view.nothing_new unless @new_item_ids
    @view.success((@app_one_items - @app_two_items).count)
  end
end