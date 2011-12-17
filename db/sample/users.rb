admin = User.find_by_email('admin@example.com')
admin.update_attributes(:password => 'moloko',
                        :password_confirmation => 'moloko')
admin.add_role(:admin)
