# -*- coding: utf-8 -*-
folder = Folder.find_by_name('Мои конспекты')
folder.parent = Folder.find_by_name('Конспекты')
folder.save

folder = Folder.find_by_name('Иванова')
folder.parent = Folder.find_by_name('Разное')
folder.save

folder = Folder.find_by_name('Петрова')
folder.parent = Folder.find_by_name('Разное')
folder.save
