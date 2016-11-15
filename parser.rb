module Parser
  # Namespaces and chains the parsing methods after initial API call
  def self.parse(scrubable)
    scrubbed = self.scrub(scrubable)
    self.dates_confirmed(scrubbed)
  end

  # For each item, go through the fields and obtain the minimum information necessary
  # in order to create a new item with the API.
  # If the 'value' key is text or a number, retrieve that
  # If the 'value' key has a 'start' or 'end' (and is thus a date), grab all date values
  # Otherwise, the field value is buried in a text key, and we grab that text.
  # Utilize uniq to remove identical objects now that they're comparable.
  def self.scrub(scrubable)
    scrubbed = scrubable["items"].map do |item|
      clean_args = {}
      clean_args["fields"] = {}
      item["fields"].each do |field|
        if field["values"].first["value"].respond_to?(:downcase) || field["values"].first["value"].respond_to?(:round)
          clean_args["fields"][field["external_id"]] = field["values"].first["value"]
        elsif field["values"].first["start"] || field["values"].first["end"]
          clean_args["fields"][field["external_id"]] = field["values"].first
        else
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