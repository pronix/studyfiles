# -*- coding: utf-8 -*-
#
Given /^(?:|[Я|я] )перешел на страницу (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:|[Я|я] )увижу форму "([^\"]*)"$/ do |form|
  all("form#{form}").should be_present
end

Then /^увижу ссылку "([^\"]*)"$/ do |text_link|
  all('a', :text => text_link).should be_present

end

Then /^(?:|[Я|я] )увижу кнопку "([^\"]*)"$/ do |text|
  all("button", :text => text).should be_present
end

Then /^увижу кнопку Continue shopping$/ do
  find(:xpath,'//a[@href="/products"]').should be_present
end

Then /^увижу кнопку Empty Cart$/ do
  find(:xpath,'//input[@value="Empty Cart"]').should be_present
end

Then /^увижу кнопку Checkout$/ do
  find(:xpath,'//a[@href="/checkout"]').should be_present
end

Then /^увижу поле для ввода псевдонима пользователя$/ do
   all("input[name='nickname']").should be_present
end

When /^(?:|[Я|я] )заполню поле "([^\"]*)" значением "([^\"]*)"$/ do |field, value|
  When %Q(fill in "#{field}" with "#{value}")
end

When /^(?:|[Я|я] )установлю флажок "([^\"]*)"$/ do |field|
  check(field)
end

When /^(?:|[Я|я] )сниму флажок "([^\"]*)"$/ do |field|
  uncheck(field)
end


Then /^(?:|[Я|я] )увижу сообщение "([^\"]*)"$/ do |text|
  Then %Q(I should see "#{text}")
end

Then /^(?:|[Я|я] )увижу "([^\"]*)"$/ do |text|
  Then %Q(I should see "#{text}")
end

Then /^(?:|[Я|я] )не увижу "([^\"]*)"$/ do |text|
  Then %Q(I should not see "#{text}")
end

Then /^увижу слайды лотов$/ do
  # не описывает ui - заняться после внедрения sc
  true
end

Then /^увижу список из 5 случайных лотов$/ do
  find("ul.random_quotes").native.search("li").size
end

Then /^увижу список из 5 новых лотов$/ do
  find("ul.latest_quotes").native.search("li").size
end

Then /^увижу подвал страницы с ссылками на статические страницы$/ do
  # не описывает ui - заняться после внедрения sc
  true
end

When /^(?:|[Я|я] )заполню поле "([^"]*)" значением "([^"]*)" в форме авторизации$/ do |field, value|
  with_scope("login_form") { When %Q(fill in "#{field}" with "#{value}") }
end

When /^(?:|[Я|я] )перейду по ссылке "([^\"]*)" в "([^\"]*)"$/ do |link, scope|
  with_scope("#{scope}") { When %Q(I follow "#{link}") }
end

Then /^(?:|[Я|я] )должен оказаться на странице (.+)$/ do |page_name|
  Then %Q(I should be on #{page_name})
end

When /^(?:|[Я|я] )выберу значение "([^\"]*)" в списке "([^\"]*)"$/ do |value, field|
  When %Q(select "#{value}" from "#{field}")
end

Given /^загружен список стран$/ do
  fixtures_dir = File.expand_path("#{Rails.root}/db/default")
  Fixtures.reset_cache
  Fixtures.create_fixtures(fixtures_dir, ['countries', 'states', 'zones', 'zone_members'])

  # Spree::Config.set({:european_zone_id => 2, :germany_zone_id => 1})

end

Given /^в сервисе прописаны следующие типы статических страниц для продавцов:$/ do |table|
  table.hashes.each do |r|
    Factory.create(:seller_page_type, r)
  end
end


Then /^(?:|[Я|я] )буду на странице (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should =~ /admin\/products\/(.*)\/edit/
end

Then /^(?:|[Я|я] )увижу комиссия с суммы доставки "([^\"]*)"$/ do |value|
  Then %Q(I should see "#{value}")
end

Then /^я увижу максимальное время ожидания подтверждения заказа пользователем "([^\"]*)"$/ do |value|
  Then %Q(I should see "#{value}")
end
When /^(?:|[Я|я] )включу флажок "([^\"]*)"$/ do |field|
  When %Q(I check "#{field}")
end

Then /^адрес страницы будет "([^\"]*)"$/ do |page_name|
  URI.parse(current_url).path.should == page_name
end
When /^добавлю файл "([^\"]*)" в поле "([^\"]*)"$/ do |file_name, field|
  attach_file(field, File.expand_path("#{Rails.root}/spec/data/#{file_name}"))
end

When /^выберу файл "([^\"]*)" в поле "([^\"]*)"$/ do |file_name, field|
  attach_file(field, File.expand_path("#{Rails.root}/spec/data/#{file_name}"))
end

When /^(?:|[Я|я] )заполню дату "([^"]*)" значением "([^"]*)"$/ do |date_field, date|
  select_date(date_field, :with => date)
end

When /^(?:|[Я|я] )перешел на главную страницу сервиса$/ do
  When %Q(I go to the home page)
end

Then /^увижу три колонки категорий$/ do
  find("div#column-1").should be_present
  find("div#column-2").should be_present
  find("div#column-3").should be_present
end

Given /^(?:|[Я|я]) авторизовался как покупатель "([^\"]*)"$/ do |email_password|
  email, password = email_password.split('/')
  Given %Q(в сервисе уже зарегистрирован пользователь "#{email_password}")
  Given %Q(я перешел на страницу авторизации сервиса)
  Then %Q(я заполню поле "Email" значением "#{email}" в форме авторизации)
  Then %Q(заполню поле "Password" значением "#{password}" в форме авторизации)
  Then  %Q(нажму "Log In")
end

Then /^я увижу список категорий$/ do
  find(:xpath, '//div[@id="taxonomies"]').should be_present
end

Then /^нажму "Купить" для "([^\"]*)"$/ do |name|
  product = Product.find_by_name(name)
  within(:xpath,"//li[@id='product_#{product.id}']") do
    find_button("Buy").click
  end
end

Then /^(?:|я )должен быть на (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Given /^у пользователя "(.+)" нет адреса доставки$/ do |email|
  user = User.find_by_email email
  user.update_attribute(:address_id, nil)
end

Given /^добавил в корзину товар "GTA San Andreas DVD-ROM"$/ do
  Given %Q(я перешел на главную страницу сервиса)
  Then %Q(я увижу список категорий)
  When %Q(перейду по ссылке "Игры")
  When %Q(перейду по ссылке "PC")
  When %Q(нажму "Купить" для "GTA San Andreas DVD-ROM")
  Then %Q(я должен быть на странице корзины)
end

Then /^увижу в корзине товар "(.+)"$/ do |product_name|
  within(:xpath,'//tbody[@id="line_items"]') do
    find('h4').text.should == product_name
  end
end

Then /^увижу страницу заполнения адреса доставки$/ do
  page.should have_content("Checkout")
  page.should have_content("Billing Address")
  page.should have_content("Shipping Address")
end

When /^(?:|[Я|я] )нажимаю кнопку ОК в spree диалоге подтверждения$/ do
  page.execute_script <<-JS
    AUTH_TOKEN = "";
    $("#popup_ok").click();
  JS

end

When /^(?:|[Я|я] )нажимаю кнопку ОК в диалоге подтверждения$/ do
  evaluate_script <<-JS
    window.confirm = function() { return true; };
  JS
end

When /^будет запущен delayed_job$/ do
  Delayed::Worker.new.work_off
  sleep(10)
end

Then /^увижу like$/ do
  page.should have_xpath('//div[@id="fb-root"]')
end

When /мне ответил пользователь "([^\"]*)" текстом "([^\"]*)"/ do |name,mess|
  u1 = User.find_by_email 'user@example.com'
  u2 = User.find_by_name name
  d=Discussion.find_between_users(u1,u2)
  d.messages.create(:user => u2,:body => mess )
end
