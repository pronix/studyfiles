# -*- coding: utf-8 -*-

Then /^я должен подтвердить регистрацию через ссылку в email пришедшую на "([^\"]*)"$/ do |email|
  Then %Q("#{email}" should receive 1 emails)
  When %Q("#{email}" opens the email)
   And %Q(I click the first link in the email)
end

Then /^администратору сервиса придет письмо о поступление новой заявки$/ do
  Then %Q(\"#{Spree::Config[:support_email]}\" should receive an emails with subject \"#{ Spree::Config[:site_name] + ' ' + I18n.t("mailer.new_claim_for_sales")}\")
end

Then /^пользователю "([^\"]*)" придет письмо о выполнение импорта товаров$/ do |email|
  Then %Q("#{email}" should receive 1 emails)
end

Then /^пользователю "([^\"]*)" придет письмо с темой "([^\"]*)"$/ do |email, subject|
  Then %Q("#{email}" should receive an emails with subject "#{subject}")
end

Then /^администратор должен получить письмо о том, что поступила новая заявка на вывод денег$/ do
  Then %Q(\"#{Spree::Config[:support_email]}\" should receive an emails with subject \"#{ Spree::Config[:site_name] + ' ' +  I18n.t("mailer.new_withdraw_to_admin")}\")
end

Then /^продавец "([^\"]*)" должен получить письмо о том, что заявка на вывод денег отправлена администратору$/ do |email|
  subject = Spree::Config[:site_name] + ' ' + I18n.t("mailer.new_withdraw_to_user")
  Then %Q("#{email}" should receive an emails with subject "#{subject}")
end

Then /^пользователю "([^\"]*)" будет отправлено писмьо что его заявка одобена$/ do |email|
  subject = Spree::Config[:site_name] + ' ' + I18n.t("mailer.response_on_claim_for_sales")
  Then %Q("#{email}" should receive an emails with subject "#{subject}")
end
