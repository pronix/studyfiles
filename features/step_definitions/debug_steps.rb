# -*- coding: utf-8 -*-
When 'I debug' do
  debugger
  true
end

Then /^показать страницу$/ do
  save_and_open_page
end
