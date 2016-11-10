module Parser

  def self.scrub(scrubable)
    confirmed = scrubable["items"].select do |item| 
      item["fields"].any? do |field| 
        field["label"] == "Scheduling Status" && field["values"].first["value"]["text"] == "Date confirmed"
      end
    end
  end

end