# language: ru
Функционал: Манипулирования с файлами и папками

  Предыстория:
    Допустим в системе существует пользователь с логином и паролем "user@example.com/secret"
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    
@green
  Сценарий: Загрузка zip архива  
    И я иду на страницу загрузки документов для пользователя "user@example.com"
    И я прикреплю файл "test_archive.zip" в поле "user_documents_attributes_2_item"
    И я нажму "Загрузить"
    И последный файл пользователя "user@example.com" имеет имя "test_archive.zip"
    И документ "test_archive.zip" должен иметь статус временный 
    И я перейду на пользовательскую страницу "user@example.com"
    И я не должен увидеть "test_archive.zip"
    И мы запустим процесс обработки файла "test_archive.zip"
    И документ "test_archive.zip" не должен существовать 
    И мы запустим процесс обработки всех файлов
    И я перейду на пользовательскую страницу "user@example.com"
    И документ "sozdanie.doc" должен иметь статус доступный
    И я должен увидеть "test_archive"
    И я должен увидеть "folder_1"
    И я должен увидеть "sozdanie.doc"
    И я должен увидеть "vshe.gif"
# @green
#   Сценарий: Редактирование атрибутов документа
#     Допустим я имею файл "бытие.doc"
#     И файл "бытие.doc" доступен
#     И я перейду на пользовательскую страницу "user@example.com"
#     И я перейду по ссылке "Редактировать"
#     И я введу "Новое название" в поле "Имя файла"
#     И я введу "Это описания файла" в поле "Описание файла"
#     И нажму "Сохранить"
#     И я должен быть на пользовательскую страницу "user@example.com"
#     И я должен увидеть "Файл обновлен"
#     И я должен увидеть "Новое название"

# @green
#   Сценарий: Редактирование атрибутов папки
#     Допустим я имею папку "Моя папка"
#     И я перейду на пользовательскую страницу "user@example.com"
#     И я перейду по ссылке "Редактировать"
#     И я введу "Новое название" в поле "Имя папки"
#     И я введу "Это описания папки" в поле "Описание папки"
#     И я нажму "Сохранить"
#     И я должен быть на пользовательскую страницу "user@example.com"
#     И я должен увидеть "Папка обновленна"
#     И я должен увидеть "Новое название"
