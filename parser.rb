module Parser

  # Namespaces and chains the parsing methods after initial API call
  def self.scrub(scrubable)
    confirmed = self.dates_confirmed(scrubable)
    unique = self.uniqify(confirmed)
  end

  # Returns only those items with Date confirmed status
  def self.dates_confirmed(scrubable)
    scrubable["items"].select do |item| 
      item["fields"].any? do |field| 
        field["label"] == "Scheduling Status" && field["values"].first["value"]["text"] == "Date confirmed"
      end
    end
  end

  # Takes scrubable items and gets rid of duplicates
  def self.uniqify(scrubable)
    
  end

end