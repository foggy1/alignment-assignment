module Authorization

  def self.get_token(args)
    response = Unirest.post "https://podio.com/oauth/token",
                 parameters:{:grant_type => "password",
                  :redirect_uri => "localhost:4567",
                  :username => args.fetch(:username),
                  :password => args.fetch(:password),
                  :client_id => args.fetch(:client_id),
                  :client_secret => args.fetch(:client_secret)}
    return response.body["access_token"]
    # Podio.setup(:api_key => args.fetch(:client_id), :api_secret => args.fetch(:client_secret))
    # Podio.client.authenticate_with_credentials(args.fetch(:username), args.fetch(:password))
    byebug
  end

  def self.get_items(token)
    response = Unirest.post "https://api.podio.com/item/app/17172422/filter/",
               headers:{"Authorization" => "OAuth2 #{token}"},
               parameters:{:sort_desc => true}
    return response.body
  end
end