module Podio

  # Retrieves access token
  def self.get_token(args={})
    response = Unirest.post "https://podio.com/oauth/token",
                 parameters:{:grant_type => "password",
                  :redirect_uri => "localhost:4567",
                  :username => args.fetch(:username),
                  :password => args.fetch(:password),
                  :client_id => args.fetch(:client_id),
                  :client_secret => args.fetch(:client_secret)}
    return response.body["access_token"]
  end

  # Retrieves items from the Meetings app
  def self.get_items(token, app_id)
    response = Unirest.post "https://api.podio.com/item/app/#{app_id}/filter/",
               headers:{"Authorization" => "OAuth2 #{token}"},
               parameters:{:sort_desc => true}
    return response.body
  end

  # Will only make items that are in app one and not also in app two.
  # Beginning with an arbitrary external id, increment, starting from number
  # of items already transferred (crudely calculated).
  # Create task for each item.
  def self.make_items(args={})
    return false unless args.fetch(:items).length > 0
    external_id = 504021412
    external_id += args.fetch(:count)
    item_ids = []
    args.fetch(:items).each do |item|
      item["external_id"] = "share_#{external_id}"
      response = Unirest.post "https://api.podio.com/item/app/17172424/",
                  headers:{"Authorization" => "OAuth2 #{args.fetch(:token)}",
                            "silent" => true,
                            "Content-Type" => "application/json"},
                  parameters:item.to_json
      Podio.make_task(item: item, 
                      ref_id: response.body["presence"]["ref_id"], 
                      token: args.fetch(:token))
      external_id += 1
    end
  end

  # Create task with appropriate title based on item.
  # Convert date info to datetime object, subtract a week, then convert back to string.
  def self.make_task(args={})
    response = Unirest.post "https://api.podio.com/task/",
                headers:{"Authorization" => "OAuth2 #{args.fetch(:token)}",
                            "Content-Type" => "application/json"},
                parameters:{"text" => "Create Agenda for #{item["fields"]["meeting-title-text"].gsub(/<\/?[^>]*>/, "")}",
                            "due_date" => (Date.parse(args.fetch(:item)["fields"]["time-date-of-meeting"]["end"]) - 7).to_s,
                            "ref_type" => "item",
                            "ref_id" => args.fetch(:ref_id)
                            }.to_json
  end


end