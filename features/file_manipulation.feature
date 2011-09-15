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
    Допустим в системе есть вузы
    Допустим в системе есть предметы

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на страницу Мои файлы
    И я нажму загрузуть файл
    И я прикреплю файл "document.doc" в поле file
    И нажму загрузить
    Тогда в папке "rails_root/public/assets/documents/:first_folder/:second_folder/:sha" появится файл с именем ":sha"
    И в БД в добавится запись в таблице "documents":
      |id|name        |description|user_id|raiting|sha            |path|
      |1 |document.doc|           |1      |0      |xxxxxxxxxxxx   |    |

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на страницу Мои файлы
    И я перейду по ссылке "Создать папку"
    И введу "new_folder" в поле "name"
    И нажму сохранить
    Тогда в БД в добавится запись в таблице "folders":
      |id|name        |description|user_id|path|
      |1 |new_folder  |           |1      |Top |

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на страницу Мои файлы
    И я скопирую файл "document.doc" в папку "new folder"
    Тогда в БД в изменится запись в таблице "documents":
      |id|name        |description|user_id|raiting|sha            |path          |
      |1 |document.doc|           |1      |0      |xxxxxxxxxxxx   |Top.new_folder|
    И я перейду по ссылке "Создать папку"
    И введу "new_folder2" в поле "name"
    И нажму сохранить
    Тогда в БД в добавится запись в таблице ":folders":
      |id|name        |description|user_id|path|
      |2 |new_folder2 |           |1      |Top |
    И я скопирую папку "new folder" в папку "new folder2"
    Тогда в БД в изменится запись в таблице "documents":
      |id|name        |description|user_id|raiting|sha            |path                      |
      |1 |document.doc|           |1      |0      |xxxxxxxxxxxx   |Top.new_folder2.new_folder|

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И у меня есть университет "НГУ - Новосибирский государственный университет"
    И я перейду на страницу Мои файлы
    И я скопирую папку "new folder2" в университет "НГУ - Новосибирский государственный университет"
    Тогда в БД в изменится запись в таблице "folders":
      |id|name        |description|user_id|path            |
      |2 |new folder2 |           |1      |1               |
      |1 |new folder1 |           |1      |1.new_folder2   |
    И в БД в изменится запись в таблице "documents":
      |id|name        |description|user_id|raiting|sha            |path                      |
      |1 |document.doc|           |1      |0      |xxxxxxxxxxxx   |1.new_folder2.new_folder  |

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И у меня есть предмет "Физика" в университете "НГУ - Новосибирский государственный университет"
    И я перейду на страницу Мои файлы
    И я скопирую папку "new folder2" в предмет "Физика"
    Тогда в БД в изменится запись в таблице "subject_folders":
      |subject_id|folder_id|
      |1         |2        |

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на страницу Мои файлы
    И у меня есть файл:
      |id|name         |description|user_id|raiting|sha            |path          |
      |2 |document2.doc|           |1      |0      |yyyyyyyyyyyy   |Top           |
    Тогда я скопирую файл "document2.doc" в университет "НГУ - Новосибирский государственный университет"
    И в БД в изменится запись в таблице "documents":
      |id|name         |description|user_id|raiting|sha            |path          |
      |2 |document2.doc|           |1      |0      |yyyyyyyyyyyy   |1             |


  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И у меня есть предмет "Физика" в университете "НГУ - Новосибирский государственный университет"
    И я перейду на страницу Мои файлы
    И я скопирую папку "document2.doc" в предмет "Физика"
    Тогда в БД в изменится запись в таблице "subject_documents":
      |subject_id|document_id|
      |1         |2          |

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на страницу Мои файлы
    И я нажму загрузуть файл
    И у меня есть архив "documents.zip" с количеством файлов "100"
    И я прикреплю файл "documents.zip" в поле file
    И нажму загрузить
    Тогда в таблице "procs" должна быть запись "extract_arh"
    И я должен видеть "Ваш архив принят на обработку"
    Тогда delayed_job подхыватывает задачу
    И по окончанию работы в табилце "documents" должно появится "100" записей
    И файл "documents.zip" должен быть удален.
    И в таблице "procs" не должно быть записи "extract_arh"
