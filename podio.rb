module Podio

  # Retrieves access token
  def self.get_token(args)
    response = Unirest.post "https://podio.com/oauth/token",
                 parameters:{:grant_type => "password",
                  :redirect_uri => "localhost:4567",
                  :username => args.fetch(:username),
                  :password => args.fetch(:password),
                  :client_id => args.fetch(:client_id),
                  :client_secret => args.fetch(:client_secret)}
    @@token = response.body["access_token"]
    return response.body["access_token"]
  end

  # Retrieves items from the Meetings app
  def self.get_items(token)
    response = Unirest.post "https://api.podio.com/item/app/17172422/filter/",
               headers:{"Authorization" => "OAuth2 #{token}"},
               parameters:{:sort_desc => true}
    return response.body
  end

  def self.make_items(items, token)
    external_id = 504021412
    item_ids = []
    items.each do |item|
      item["external_id"] = "share_#{external_id}"
      response = Unirest.post "https://api.podio.com/item/app/17172424/",
                  headers:{"Authorization" => "OAuth2 #{token}",
                            "Content-Type" => "application/json"},
                  parameters:item.to_json
      item_ids << response.body
      external_id += 1
    end
    item_ids
  end

end