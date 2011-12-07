# language: ru
Функционал:
  Работа с файлами.
  Скачивание одного файла и нескольких файлов архивом, и папку с количеством файлов больше 100-та
  Скачивание каждого 10-го файла должно сопроваждаться вводом капчи
  Скачивание файлов незарегистрированным пользователем
  Предпросмотр файлов и папок
  Групировка по ВУЗам
  Поиск по содержимому файлов

# В предыстории введем данные по университетам:
#Заполнение согласно PDF со страницы 9
  Предыстория:
    Допустим в системе есть вузы
    Допустим в системе существует пользователь с логином и паролем "user@example.com/secret"
    Допустим в системе есть файлы

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я на главной странице
    И я перейду по ссылке "Файлы"
    И я перейду по ссылке "Выбрать университет"
    И я перейду по ссылке "Московский государственный университет"
    То я увижу "Учебники"
    И я увижу "Методички"
    И я увижу "Конспекты"
    И я увижу "Разное"
    ##И я не должен увидеть папку "Иванова"
    ##И я не должен увидеть папку "Петрова"
    ##И я не должен увидеть папку "Мои конспекты"
    ##И я не должен увидеть файл "Конспект.doc"
    ##И я не должен увидеть файл "Документ 1"
    ##И я не должен увидеть файл "Длинные названия и описания сокращаются до"
    ##И я не должен увидеть файл "Документ 3"
    ##Тогда я перейду по ссылке "Раскрыть Конспекты"
    И я увижу "Иванова"
    И я увижу "Петрова"
    И я увижу "Мои конспекты"
    И я увижу "Конспект.doc"
    И покажи страницу
    #Тогда я перейду по ссылке "Раскрыть Мои конспекты"
    И я увижу "Документ 1"
    И я увижу "Длинные названия и описания сокращаются до"
    И я не увижу "Длинные названия и описания сокращаются до коротких названий и описаний"
    И я увижу "Документ 3"

  Сценарий:
    Допустим я зашел как пользователь с логином и паролем "user@example.com/secret"
    И я на главной странице
    Тогда я перейду по ссылке "Файлы"
    И я перейду по ссылке "Выбрать университет"
    И я перейду по ссылке "Московский государственный университет"
    И я перейду по ссылке "Скачать КВопросы к экзамену.doc"
    И я должен скачать файл "КВопросы к экзамену.doc"
    Тогда я перейду по ссылке "Скачать Методички"
    И я должен увидеть "Скачать архив 1 из 2"
    И я должен ввести валидную капчу
    И я нажму "Скачать"
    Тогда я должен скачать файл "Konspekti_1.zip"
    И я должен увидеть "Скачать архив 2 из 2"
    И я должен ввести валидную капчу
    И я нажму "Скачать"
    Тогда я должен скачать файл "Konspekti_2.zip"
    Допустим существует папка "Тест100" с количеством файлов "101"
    И я перейду по ссылке "Скачать Тест100"
    Тогда я должен увидеть "Выбранная папка слишком большая, попробуйте скачать подпапки"
    И я перейду по ссылке "Выйти"

  Сценарий:
    Допустим я зарегистрирован как пользователь с логином и паролем "new@example.com/secret"
    И я зашел как пользователь  с логином и паролем "new@example.com/secret"
    И пользователь "new@example.com" скачал "9" файлов
    Тогда я перейду по ссылке "Файлы"
    И я перейду по ссылке "Выбрать университет"
    И я перейду по ссылке "Московский государственный университет"
    И я перейду по ссылке "Скачать КВопросы к экзамену.doc"
    И я должен ввести валидну капчу
    И я нажму на кнопку "Скачать"
    И я должен скачать файл "КВопросы к экзамену.doc"
    И я перейду по ссылке "Выйти"

  Сценарий:
    Допустим я на главной странице
    Тогда я перейду по ссылке "Файлы"
    И я перейду по ссылке "Выбрать университет"
    И я перейду по ссылке "Московский государственный университет"
    И я перейду по ссылке "Скачать КВопросы к экзамену.doc"
    И я должен ввести валидну капчу
    И я нажму на кнопку "Скачать"
    И я должен скачать файл "КВопросы к экзамену.doc"
    Тогда я перейду по ссылке "Скачать Методички"
    И я должен увидеть "Для скачивания папок необхадимо зарегистрироваться"

  Сценарий:
    Допустим я зашел как пользователь с логином и паролем "user@example.com/secret"
    И я на главной странице
    Тогда я перейду по ссылке "Файлы"
    И я перейду по ссылке "Выбрать университет"
    И я перейду по ссылке "Московский государственный университет"
    И я перейду по ссылке "Раскрыть Конспекты"
    И я должен увидеть папку "Мои конспекты"
    Тогда я перейду по ссылке "Предпросмотр Мои конспекты"
    И я должен увидеть "Пожаловаться на папку"
    И я должен увидеть "Скачать все"
    И я должен увидеть файл "Документ 1"
    И я должен увидеть файл "Длинные названия и описания сокращаются до"
    И я должен увидеть файл "Документ 3"
    И я перейду по ссылке "Предпросмотр Документ 3"
    Тогда я должен увидеть "Пожаловать на файл"
    И я должен увидеть "Скачать"
    И я не должен увидеть файл "Документ 1"
    И я не должен увидеть файл "Длинные названия и описания сокращаются до"
    И я должен увидеть содержимое файла "Документ 3"
    И я перейду по ссылке "Пожаловаться на файл"
    И я введу "Жалоба на файл" в поле "body"
    И я нажму "Отправить"
    И я должен увидеть "Сообщение отправленно администратору"
    И я перейду по ссылке "Пожаловаться на файл"
    И я введу "Жалоба на файл с Email" в поле "body"
    И я введу "user@example.com" в поле "email"
    И нажму "Отправить"
    И я должен увидеть "Сообщение отправленно администратору"
    И должен отправится email на адрес администратора с полями ОТ:"user@example.net" ТЕКСТ СООБЩЕНИЯ:"Жалоба на файл с Email"

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я на главной странице
    И я перейду на вкладку "Файлы"
    И я перейду по ссылке "Выбрать предмет"
    И я перейду по ссылке "Молекулярная физика"
    И я перейду по ссылке "рейтингу"
    И я перейду по ссылке "по ВУЗам"
    Тогда я должен видеть элементы в таком пордяке "Московский государственный университет,Московский государственный институт электронной техники"
    Тогда я должен видеть элементы в таком пордяке "Конспекты,Учебники,Методички,КВопросы к экзамену.doc,Разное"

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я на главной странице
    И я перейду на вкладку "Файлы"
    И я перейду по ссылке "Поиск по содержимому файлов"
    И я введу "Вопросы термодинамики" в поле "search"
    И нажму "найти"
    И я должен увидеть ответ от Яндекс XML

#    Тогда я должен увидеть "Яндекс нашел 2 страницы"
# Результаты поиска зависят от Яндекса. Вероятно при тестировании результаты поиска будут отсутствовать.
#   И я должен увидеть "Физика / Вопросы на экзмен по термодинамики"
#    И я должен увидеть "Физика / Основы термодинамики"
