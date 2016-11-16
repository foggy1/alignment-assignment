module Parser
  # Namespaces and chains the parsing methods after initial API call
  def self.parse(scrubable)
    scrubbed = self.scrub(scrubable)
    self.dates_confirmed(scrubbed)
  end

  # For each item, go through the fields and obtain the minimum information necessary
  # in order to create a new item with the API.
  # According to the way Podio nests values in a given field type, retrieve that data.
  # Utilize uniq to remove identical objects now that they're comparable.
  def self.scrub(scrubable)
    scrubbed = scrubable["items"].map do |item|
      clean_args = {}
      clean_args["fields"] = {}
      item["fields"].each do |field|
        if field["type"] == "text" || 
           field["type"] == "location" ||
           field["type"] == "progress"
          clean_args["fields"][field["external_id"]] = field["values"].first["value"]
        elsif field["type"] == "date"
          clean_args["fields"][field["external_id"]] = field["values"].first
        elsif field["type"] == "category"
          clean_args["fields"][field["external_id"]] = field["values"].first["value"]["text"]
        end
      end
      clean_args
    end
    scrubbed.uniq
  end

  # Returns only those items with Date confirmed status
  def self.dates_confirmed(scrubbed)
    scrubbed.select{ |item| item["fields"]["status"] == "Date confirmed" }
  end

end