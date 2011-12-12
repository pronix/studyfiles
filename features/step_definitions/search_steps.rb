# -*- coding: utf-8 -*-


Given /^в системе есть следующие предметы:$/ do |table|
  table.hashes.each do |attrs|      
    ids = attrs[:university_ids].split(", ")
    Factory.create(:subject, {:id => attrs[:id], :name => attrs[:name], :university_ids => ids})
  end
end

