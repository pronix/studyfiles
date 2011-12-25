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
    u_count = University.count
    s_count = Subject.count
    d_count = Document.count
    "На сайте: #{u_count} #{t(:univer_abbr, :count => u_count)}, #{s_count} #{t(:subject, :count => s_count)}, #{d_count} #{t(:file, :count => d_count)} на #{number_to_human_size Document.sum(:item_file_size)}"
  end
end
