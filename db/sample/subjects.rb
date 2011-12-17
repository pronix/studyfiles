# -*- coding: utf-8 -*-
univer = University.find_by_abbreviation('МГУ')
Subject.all.each {|s| s.universities << univer}
