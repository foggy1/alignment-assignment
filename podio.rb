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
  def self.get_items(token, app_id)
    response = Unirest.post "https://api.podio.com/item/app/#{app_id}/filter/",
               headers:{"Authorization" => "OAuth2 #{token}"},
               parameters:{:sort_desc => true}
    return response.body
  end

  def self.make_items(count, items, token)
    return false unless items.length > 0
    external_id = 504021412
    external_id += count
    item_ids = []
    items.each do |item|
      item["external_id"] = "share_#{external_id}"
      response = Unirest.post "https://api.podio.com/item/app/17172424/",
                  headers:{"Authorization" => "OAuth2 #{token}",
                            "silent" => true,
                            "Content-Type" => "application/json"},
                  parameters:item.to_json
      Podio.make_task(item, response.body["presence"]["ref_id"], token)
      external_id += 1
    end
  end

  def self.make_task(item, ref_id, token)
    response = Unirest.post "https://api.podio.com/task/",
                headers:{"Authorization" => "OAuth2 #{token}",
                            "Content-Type" => "application/json"},
                parameters:{"text" => "Create Agenda for #{item["fields"]["meeting-title-text"].gsub(/<\/?[^>]*>/, "")}",
                            "due_date" => (Date.parse(item["fields"]["time-date-of-meeting"]["end"]) - 7).to_s,
                            "ref_type" => "item",
                            "ref_id" => ref_id
                            }.to_json
  end


end