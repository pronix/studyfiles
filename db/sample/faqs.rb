Faq.top_level.each do |faq|
  1.upto(rand(20)+1).each do
    f = Faq.create(:question => Faker::Lorem.words.join(" "),
                   :answer => Faker::Lorem.paragraphs.join("\n"))
    f.parent = faq
    f.save
  end
end
