# -*- coding: utf-8 -*-
module UniversitiesHelper

  #сортировка по городам
  def sort_by_city(universities)
    array = Array.new
    cities = Array.new
    universities.each {|univer|
      cities.push(univer.city)
    }
    cities.uniq.sort.each {|city|
      array.push universities.where(:city => city)
    }
    return array
  end

  #Статистика для поиска
  def search_statistic(university = nil)
     "На сайте: #{University.count} ВУЗов, #{Subject.count} предметов, #{Document.count} файлов на #{((Document.sum(:item_file_size).to_f / (1024**3)).round(1))} Гб"
  end
end
