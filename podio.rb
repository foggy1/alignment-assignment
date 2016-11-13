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
    params = {"fields" => items.first}
    response = Unirest.post "https://api.podio.com/item/app/17172424/",
                headers:{"Authorization" => "OAuth2 #{token}",
                          "Content-Type" => "application/json"},
                parameters:params.to_json
    byebug
  end

  # def self.make_field(field)
  #   response = Unirest.post "https://api.podio.com/app/17172424/field/",
  #     headers:{"Authorization" => "OAuth2 #{@@token}",
  #     "Content-Type" => "application/json"},
  #     parameters: {"type"=>"text", "label"=>"Meeting Title", "config"=>{"settings"=>{"format"=>"html", "size"=>"large"}, "mapping"=>nil, "label"=>"Meeting Title"}}.to_json
  # end
end