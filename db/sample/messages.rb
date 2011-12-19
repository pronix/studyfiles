recipient = User.find_by_email('admin@example.com')

User.first(5).each do |s|
  discussion = Discussion.create(:recipient_tokens => [s.id, recipient.id])
  1.upto(rand(10)).each do |i|
    if i%2 != 0
      Message.create(:discussion => discussion, :user => s, :body => Faker::Lorem.paragraph.to_s)
    else
      Message.create(:discussion => discussion, :user => recipient, :body => Faker::Lorem.paragraph.to_s)
    end
  end
end
