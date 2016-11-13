module Parser
  # Namespaces and chains the parsing methods after initial API call
  def self.parse(scrubable)
    scrubbed = self.scrub(scrubable)
    self.dates_confirmed(scrubbed)
  end

  # Checks field label and retrieves its associated value
  # These are made into key value pairs
  def self.scrub(scrubable)
    scrubbed = scrubable["items"].map do |item|
      clean_args = {}
      clean_args["fields"] = {}
      item["fields"].each do |field|
        if field["values"].first["value"].respond_to?(:downcase) || field["values"].first["value"].respond_to?(:round)
          clean_args["fields"][field["external_id"]] = field["values"].first["value"]
        elsif field["values"].first["end"]
          clean_args["fields"][field["external_id"]] = field["values"].first
        else
          clean_args["fields"][field["external_id"]] = field["values"].first["value"]["text"]
        end
      end
      clean_args
    end
    # Remove duplicates
    scrubbed.uniq
  end

  # Returns only those items with Date confirmed status
  def self.dates_confirmed(scrubbed)
    scrubbed.select{ |item| item["fields"]["status"] == "Date confirmed" }
  end

end