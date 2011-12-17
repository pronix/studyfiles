# -*- coding: utf-8 -*-
Допустим /^я не должен увидеть "(.+)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end
