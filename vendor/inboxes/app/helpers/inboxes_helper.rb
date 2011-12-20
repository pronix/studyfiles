require 'net/http'
module InboxesHelper
  def messages_by_user(user)
    amount = current_user.sender_messages(user).count
    "#{amount} #{t(:message, :count => amount)}"
  end
  
  def inboxes_faye_broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => defined?(FAYE_TOKEN) ? FAYE_TOKEN : ""}}
    uri = URI.parse("http://#{Inboxes::config.faye_host}:#{Inboxes::config.faye_port}/faye")
    # Rails.logger.info "Faye URL: #{uri}"
    res = Net::HTTP.post_form(uri, :message => message.to_json)
  end
end
