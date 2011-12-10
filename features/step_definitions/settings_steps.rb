# -*- coding: utf-8 -*-
Допустим /^я имею слудующию конфигурацию:$/ do |table|
  table.hashes.each {|h| Factory(:setting, :var => h[:var], :value => h[:value])}
end
