module AccountsHelper
  def unread_messages_count
    unread = current_user.unread_messages_count
    "#{unread} #{t(:message, :count => unread)}"
  end
end
