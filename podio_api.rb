module PodioApi

  # Establishes connection and initializes Podio singleton
  def self.auth(args)
    Podio.setup(:api_key => args.fetch(:client_id), :api_secret => args.fetch(:client_secret))
    Podio.client.authenticate_with_credentials(args.fetch(:username), args.fetch(:password))
  end


  # Retrieves items from the Meetings app
  def self.get_items
    items = Podio::Item.find_all(17172422, {"sort_desc": true})
    byebug
  end

  # Create new items on the second board with info scrubbed from first.
  # Receive those item_id's on callback.  Use them as ref on task creation.
  def self.post_tasks(args)

  end
end