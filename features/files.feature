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
    

@green
  Сценарий:
    Допустим есть следующие папки принадлежащии универу "МГУ":
      | name      |
      | Папка 1   |
      | Папка 1-1 |
      | Папка 1-2  |
    И папка "Папка 1-1" пренадлежит папке "Папка 1"
    И папка "Папка 1-2" пренадлежит папке "Папка 1"
    И в папке "Папка 1-1" есть документ "Документ 1"
    И речекни университеты!
    И сфинкс индексируйся!
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я на главной странице
    И я перейду по ссылке "Московский государственный университет"
    То я увижу "Папка 1"
    И я увижу "Папка 1-1"
    И я увижу "Папка 1-2"
    И я увижу "Документ 1"

@green
  Сценарий: Скачивание одного файла
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    Допустим в университете "МГУ" есть документ "документ1"
    И речекни университеты!
    И сфинкс индексируйся!
    И я на главной странице
    И файл "документ1" доступен  
    И я перейду по ссылке "Московский государственный университет"
    И я перейду по ссылке "Скачать документ1"
    Тогда получу файл с именем "документ1.doc"
@green
  Сценарий: Скачивание папки
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    Допустим есть следующие папки принадлежащии универу "МГУ":
      | name      |
      | Папка 1   |
      | Папка 1-1 |
      | Папка 1-2  |
    И папка "Папка 1-1" пренадлежит папке "Папка 1"
    И папка "Папка 1-2" пренадлежит папке "Папка 1"
    И в папке "Папка 1-1" есть документ
    И в папке "Папка 1-2" есть документ
    И речекни университеты!
    И сфинкс индексируйся!
    И я на главной странице
    И я перейду по ссылке "Московский государственный университет"
    И я перейду по ссылке "Скачать Папка 1"
    Тогда получу файл с именем "Папка 1.zip"

# @green @current
#   Сценарий: Только зарегистрированный пользователь может скачивать файлы
#     Допустим в университете "МГУ" есть документ "документ1"
#     Допустим есть следующие папки принадлежащии универу "МГУ":
#       | name      |
#       | Папка 1   |
#       | Папка 1-1 |
#       | Папка 1-2 |
#     И папка "Папка 1-1" пренадлежит папке "Папка 1"
#     И папка "Папка 1-2" пренадлежит папке "Папка 1"
#     И в папке "Папка 1-1" есть документ
#     И файл "документ1" доступен
#     И речекни университеты!
#     И сфинкс индексируйся!
#     Допустим я на главной странице 
#     И я перейду по ссылке "Московский государственный университет"
#     И я перейду по ссылке "Скачать документ1"
#     Тогда получу файл с именем "документ1.doc"
#     Допустим я на главной странице
#     И я перейду по ссылке "Московский государственный университет"
#     И покажи страницу
#     И я перейду по ссылке "Скачать Папка 1"
#     И я должен увидеть "Для скачивания папок необхадимо зарегистрироваться"
@green
  Сценарий:
    Допустим я имею слудующию конфигурацию:
      | var         | value             |
      | admin_email | admin@example.com |
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    Допустим есть следующие папки принадлежащии универу "МГУ":
      | name      |
      | Папка 1   |
      | Папка 1-1 |
      | Папка 1-2  |
    И папка "Папка 1-1" пренадлежит папке "Папка 1"
    И папка "Папка 1-2" пренадлежит папке "Папка 1"
    И в папке "Папка 1-1" есть документ "Документ 1"
    И документ "Документ 1" уже сконвертировался
    И речекни университеты!
    И сфинкс индексируйся!
    И я на главной странице
    И я перейду по ссылке "Московский государственный университет"
    И я перейду по ссылке "Открыть Папка 1"
    И я должен увидеть "Папка 1"
    И я должен увидеть "Пожаловаться на папку" 
    И я должен увидеть "Скачать все"
    И я должен увидеть "Документ 1"
    И я перейду по ссылке "Предпросмотр Документ 1"
    И я должен увидеть "Глава 5"
    И я перейду по ссылке "Пожаловаться на файл"
    И я введу "Жалоба на файл" в поле "Ваше сообщение"
    И я нажму "Отправить"
    И я должен увидеть "Ваше сообщение отправленно администрации"
    И должено отправиться 1 email на адрес "admin@example.com"
    И открываем последнее письмо для "admin@example.com"
    И письмо должно содержать "Жалоба на файл"
@green
  Сценарий: Работа с разделом Файлы
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    Допустим рейтинг университета "МГУ" 100
    Допустим в университете "МГУ" есть следующие предметы:
      | name         |
      | Химия        |
      | Русский Язык |
      | Математика   |
    Допустим предмет в универе "МГУ" "Химия" имеет следующие папки:
      | name      |
      | Учебная   |
      | Методичка |
    И речекни университеты!
    И сфинкс индексируйся!
    И я на главной странице
    И я перейду по ссылке "Файлы"
    И я должен увидеть "Химия"
    И я должен увидеть "Русский Язык"
    И я должен увидеть "Учебная" 
    И я должен увидеть "Методичка"
    И я должен увидеть "МГУ"

@green @current
  Сценарий: Поиск по названию или описанию файла или папки
    Допустим есть следующие папки принадлежащии универу "МГУ":
      | name    | description      |
      | Папка 1 | Описание папки 1 |
      | Папка 2 | Описание папки 2 |
    Допустим университет "МГУ" имеет следующие файлы:
      | name       | description          |
      | Документ 1 | Описание документа 1 |
      | Документ 2 | Описание документа 2 |
    И файл "Документ 1" доступен
    И файл "Документ 2" доступен
    И файл "Документ 1" имеет только вуз
    И файл "Документ 2" имеет только вуз
    И речекни университеты!
    И сфинкс индексируйся!
    И я иду на файлы
    И я должен увидеть "Документ 1"
    И я должен увидеть "Папка 1"

    И я введу "папка 1" в поле "search"
    И я нажму "Найти"
    И я должен быть на поиск в файлах
    И я должен увидеть "Папка 1"
    И я не должен видеть "Папка 2"
    И я не должен видеть "Документ 1"

    И я введу "описание папки 2" в поле "search"
    И я нажму "Найти"
    И я должен увидеть "Папка 2"
    И я не должен видеть "Папка 1"
    И я не должен видеть "Документ 1"

    И я введу "документ 1" в поле "search"
    И я нажму "Найти"
    И я должен увидеть "Документ 1"
    И я не должен видеть "Папка 1"
    И я не должен видеть "Документ 2"

 # Сценарий:
  #   Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
  #   И я на главной странице
  #   И я перейду на вкладку "Файлы"
  #   И я перейду по ссылке "Поиск по содержимому файлов"
  #   И я введу "Вопросы термодинамики" в поле "search"
  #   И нажму "найти"
  #   И я должен увидеть ответ от Яндекс XML

#    Тогда я должен увидеть "Яндекс нашел 2 страницы"
# Результаты поиска зависят от Яндекса. Вероятно при тестировании результаты поиска будут отсутствовать.
#   И я должен увидеть "Физика / Вопросы на экзмен по термодинамики"
#    И я должен увидеть "Физика / Основы термодинамики"
