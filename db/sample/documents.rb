Document.all.each do |d|
  d.update_attribute(:item, File.new(Rails.root.join("sample_documents/#{d.name}")))
  d.process
end
