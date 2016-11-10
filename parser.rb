module Parser

  # Namespaces and chains the parsing methods after initial API call
  def self.parse(scrubable)
    scrubbed = self.scrub(scrubable)
    byebug
    confirmed = self.dates_confirmed(scrubbed)
    unique = self.uniqify(confirmed)
  end

  def self.scrub(scrubable)
    scrubable["items"].map do |item|
      clean_args = {}
      item["fields"].each do |field|
        clean_args[field["label"]] = "test"
      end
      return clean_args
    end
  end
  # Returns only those items with Date confirmed status
  def self.dates_confirmed(scrubable)
    scrubable["items"].select do |item| 
      item["fields"].any? do |field| 
        field["label"] == "Scheduling Status" && field["values"].first["value"]["text"] == "Date confirmed"
      end
    end
  end

  # Rejects items with repeat title and datetimes
  def self.uniqify(scrubable)
    # check_duplicates = []
    # scrubable.reject do |item|
    #   item["fields"].any? do |field|
    #     pair = []
    #     if check_duplicates.empty? && field["label"] == "Meeting Title" || 
    #       field["label"] == "Time & Date of Meeting"
    #     end
    #   end
    # end
  end

end