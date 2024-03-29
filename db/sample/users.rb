admin = User.find_by_email('admin@example.com')
admin.update_attributes(:password => 'moloko',
                        :password_confirmation => 'moloko')
admin.add_role(:admin)

def rand_avatar
  File.new Dir.glob(Rails.root.join('db/sample/avatars', '*')).shuffle.first
end

User.all.each do |u|
  u.update_attribute(:avatar, rand_avatar)
  u.universities << University.all.shuffle.first(rand(3))
end

# Create overall rating
User.rank!
