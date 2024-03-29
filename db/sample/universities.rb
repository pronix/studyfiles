# -*- coding: utf-8 -*-
University.find_by_abbreviation('МГУ').update_attribute(:logo, File.new(Rails.root.join('sample_documents/mgu_logo.jpg')))
University.find_by_abbreviation('ПНИПУ').update_attribute(:logo, File.new(Rails.root.join('sample_documents/pnipu.png')))
University.find_by_abbreviation('ВШЭ').update_attribute(:logo, File.new(Rails.root.join('sample_documents/vshe.gif')))

def rand_logo
  File.new Dir.glob(Rails.root.join('db/sample/logos', '*')).shuffle.first
end

University.where("name like 'Универсистет%'").each do |u|
  u.update_attribute(:logo, rand_logo)
end
