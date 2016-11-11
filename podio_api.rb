module PodioApi

  # Retrieves access token
  def self.auth(args)
    Podio.setup(:api_key => args.fetch(:client_id), :api_secret => args.fetch(:client_secret))
    Podio.client.authenticate_with_credentials(args.fetch(:username), args.fetch(:password))
  end

  def self.testIt
    my_orgs = Podio::Organization.find_all

    my_orgs.each do |org|
      puts org.name
      puts org.url
    end
  end

  # Retrieves items from the Meetings app
  def self.get_items(token)
    response = Unirest.post "https://api.podio.com/item/app/17172422/filter/",
               headers:{"Authorization" => "OAuth2 #{token}"},
               parameters:{:sort_desc => true}
    return response.body
  end

  # Create new items on the second board with info scrubbed from first.
  # Receive those item_id's on callback.  Use them as ref on task creation.
  def self.post_tasks(args)
    response = Unirest.post "https://api.podio.com/item/app/17172424/",
                headers:{"Authorization" => "OAuth2 #{args.fetch(:token)}", 
                         "Accept" => "application/json" },
                parameters:{:fields => args.fetch(:items).first}.to_json
    byebug
  end
end