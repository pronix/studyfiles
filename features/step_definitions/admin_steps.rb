# -*- coding: utf-8 -*-
Допустим /^я уже имею неотредактированную новость:$/ do |table|
  table.hashes.each do |hash|
    Factory(:novelty, hash)
  end
end
