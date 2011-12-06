# -*- coding: utf-8 -*-

Given /^в системе есть вузы$/ do 
  University.count.should be > 0
end
