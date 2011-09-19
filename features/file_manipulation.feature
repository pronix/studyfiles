# language: ru

Функционал:
  Закачка файла
  Создание папки
  Копирование файла в папку
  Копирование папки в Вуз
  Копирование папки в предмет
  Копирование файла в Вуз
  Копирование файла в предмет
  Загрузка архива (всегда через delay_job)
  
  Предыстория:
    #Допустим в системе есть вузы
    #Допустим в системе есть предметы

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на страницу Мои файлы
    И я перейду по ссылке "загрузить файлы"
    И я прикреплю файл "document.doc" в поле "document_item"
    И нажму "Загрузить"
    Тогда в папке "/public/assets/documents/e7/7a" появится файл с именем "e77a100ceb4e7023a49d5391dfeb20c3f84f8611"
    И в БД добавится запись в таблице документов:
      |id|name        |description|user_id|sha                                     |path|
      |1 |document.doc|           |1      |e77a100ceb4e7023a49d5391dfeb20c3f84f8611|Top |

#  Сценарий:
#    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на страницу Мои файлы
    И я перейду по ссылке "Создать папку"
    И я введу в поле "name" значение "new_folder"
    И нажму "Создать"
    Тогда в БД добавится запись в таблице папок:
      |id|name        |description|user_id|path|
      |1 |new_folder  |           |1      |Top |

#  Сценарий:
#    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на страницу Мои файлы
    И я скопирую файл "document.doc" в папку "new_folder"
    Тогда в БД изменится запись в таблице документов:
      |id|name        |description|user_id|raiting|sha                                     |path          |
      |1 |document.doc|           |1      |0      |e77a100ceb4e7023a49d5391dfeb20c3f84f8611|Top.new_folder|
    И я перейду по ссылке "Создать папку"
    И я введу в поле "name" значение "new_folder2"
    И нажму "Создать"
    Тогда в БД добавится запись в таблице папок:
      |id|name        |description|user_id|path|
      |2 |new_folder2 |           |1      |Top |
    И я скопирую папку "new_folder" в папку "new_folder2"
    И в БД изменится запись в таблице папок:
      |id|name        |description|user_id|path             |
      |1 |new_folder  |           |1      |Top.new_folder2   |
    И в БД изменится запись в таблице документов:
      |id|name        |description|user_id|raiting|sha                                     |path                      |
      |1 |document.doc|           |1      |0      |e77a100ceb4e7023a49d5391dfeb20c3f84f8611|Top.new_folder2.new_folder|

#  Сценарий:
#    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И у меня есть университет "Новосибирский государственный университет" с аббривиатурой "НГУ"
    И я перейду на страницу Мои файлы
    И я скопирую папку "new_folder2" в университет "Новосибирский государственный университет"
    Тогда в БД изменится запись в таблице папок:
      |id|name        |description|user_id|path            |
      |2 |new_folder2 |           |1      |id_НГУ               |
      |1 |new_folder  |           |1      |id_НГУ.new_folder2   |
    И в БД изменится запись в таблице документов:
      |id|name        |description|user_id|raiting|sha                                        |path                      |
      |1 |document.doc|           |1      |0      |e77a100ceb4e7023a49d5391dfeb20c3f84f8611   |id_НГУ.new_folder2.new_folder  |

#  Сценарий:
#    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И у меня есть предмет "Физика" в университете "Новосибирский государственный университет"
    И я перейду на страницу Мои файлы
    И я скопирую папку "new_folder2" в предмет "Физика"
#тут сравнение по id через имена
    Тогда в БД изменится запись в таблице subject_folders:
      |subject|folder     |
      |Физика |new_folder2|

#  Сценарий:
#    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на страницу Мои файлы
    И я перейду по ссылке "загрузить файлы"
    И я прикреплю файл "document2.doc" в поле "document_item"
    И нажму "Загрузить"
    И в БД добавится запись в таблице документов:
      |id|name         |description|user_id|raiting|sha                                     |path|
      |2 |document2.doc|           |1      |0      |38a03e32de216e49c79b7f94d03fc493ef586777|Top |
    Тогда я скопирую файл "document2.doc" в университет "Новосибирский государственный университет"
    И в БД добавится запись в таблице документов:
      |id|name         |description|user_id|raiting|sha                                     |path  |
      |2 |document2.doc|           |1      |0      |38a03e32de216e49c79b7f94d03fc493ef586777|id_НГУ|

#  Сценарий:
#    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на страницу Мои файлы
    И я скопирую файл "document2.doc" в предмет "Физика"
    Тогда в БД в изменится запись в таблице subject_documents:
      |subject|document     |
      |Физика |document2.doc|

#  Сценарий:
#    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
#    И я перейду на страницу Мои файлы
#    И я перейду по ссылке "загрузить файлы"
#    И у меня есть архив "documents.zip" с количеством файлов "100"
#    И я прикреплю файл "documents.zip" в поле file
#    И нажму загрузить
#    Тогда в таблице "procs" должна быть запись "extract_arh"
#    И я должен видеть "Ваш архив принят на обработку"
#    Тогда delayed_job подхыватывает задачу
#    И по окончанию работы в табилце "documents" должно появится "100" записей
#    И файл "documents.zip" должен быть удален.
#    И в таблице "procs" не должно быть записи "extract_arh"