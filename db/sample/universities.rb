# -*- coding: utf-8 -*-
University.find_by_abbreviation('МГУ').update_attribute(:logo, File.new(Rails.root.join('sample_documents/mgu_logo.jpg')))
University.find_by_abbreviation('ПНИПУ').update_attribute(:logo, File.new(Rails.root.join('sample_documents/pnipu.png')))
University.find_by_abbreviation('ВШЭ').update_attribute(:logo, File.new(Rails.root.join('sample_documents/vshe.gif')))
