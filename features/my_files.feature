# language: ru
Функционал:
  Содержимое страницы пользователя
  Редактирование файлов
  Формирование страницы пользователя
  Загрузка одного файла
  Загрузка архива
  Редактирование ВУЗов и Предметов

# В предыстории введем данные по университетам:
#Заполнение согласно PDF с 22-ой страницы
#Временное ограничение на длину имени файла 50, потом исправится после прикручивания верстки
  Предыстория:
    Допустим в системе есть вузы
    Допустим в системе существует пользователь с логином и паролем "user@example.com/secret"
    #Допустим в системе существуют файлы для всех предметов

  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду по ссылке "Мои файлы"
    И я увижу "Несортированные файлы"
    И я должен увидеть список файлов:
      |rait|name                                                                                       |description                                                                                   |size    |
      |+5  |Учебники                                                                                   |                                                                                              |3 файла  |
      |0   |Конспекты                                                                                  |                                                                                              |18 файлов|
      |-2  |Новая папка                                                                                |Данное руководство предназначено для студентов, изучающих язык Паскаль и выполняющих работы по|6 файлов |
      |0   |Лабораторная работа №1                                                                     |                                                                                              |8,1 Мб  |
      |0   |Лабораторная работа №2                                                                     |                                                                                              |5,8 Мб  |
      |0   |Длинные названия и описаня сокращаются до одной строчки теперь не справедливо дял файлов   |                                                                                              |5,8 Мб  |
      |0      |Длинные названия и описания |                                                                                              |5,8 Мб  |
    И я должен видеть "Действия"
    И я должен видеть "Новость 1"
    И я должен видеть "Новость 2"
    И я должен видеть "Фильтр"
    И я должен видеть "Несортированные файлы не отображаются в общем каталоге, но доступны другим пользователям для скачивания с вашей страницы"
    И я должен видеть "Чтобы добавить файлы в общий каталог: ..."
    Тогда я перейду по ссылке "Раскрыть описание Новая папка"
    И я должен видеть "Данное руководство предназначено для студентов, изучающих язык Паскаль и выполняющих работы по этому языку. Тема 1. Поняте рекурсии, рекурсивной процедуры. Примеры рекурсивных алгоритмов. Понятие рекурсии, рекурсивной процедуры."
    Тогда я перейду по ссылке "Свернуть описание Новая папка"
    И я не должен видеть "Данное руководство предназначено для студентов, изучающих язык Паскаль и выполняющих работы по этому языку. Тема 1. Поняте рекурсии, рекурсивной процедуры. Примеры рекурсивных алгоритмов. Понятие рекурсии, рекурсивной процедуры."
    Тогда я перейду по ссылке "Редактировать Лабораторная работа №2"
    И я введу "Отредактированная Лабораторная работа" в поле "name"
    И я введу "Описание для отредактированная Лабораторная работа" в поле "description"
    И я перейду по ссылке "Отменить"
    Тогда я должен видеть "Лабораторная работа №2"
    И я не должен видеть "Отредактированная Лабораторная работа"
    Тогда я перейду по ссылке "Редактировать Лабораторная работа №2"
    И я введу "Отредактированная Лабораторная работа" в поле "name"
    И я введу "Описание для отредактированная Лабораторная работа с очень длинным именем для проверки максималного количества символов" в поле "description"
    И я должен видеть "Имя файла слишком длинное, максимальное количество 50 символов"
    И я введу "Описание для отредактированная Лабораторная работа" в поле "description"
    И я нажму "Сохранить"
    Тогда я должен видеть "Отредактированная Лабораторная работа"
    И я должен видеть "Описание для отредактированная Лабораторная работа"
    И я не должен видеть "Лабораторная работа №2"



# @green @javascript @wip
#   Сценарий:
#     Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
#     И у пользователя "user@example.com" нету файлов
#     И я перейду по ссылке "Мои файлы"
#     Тогда я увижу "Несортированные файлы"
#     И я увижу "Добавить файлы"
#     И я увижу "Добавить ВУЗ"
#     Тогда я перейду по ссылке "Добавить файлы"
#     И я прикреплю файл "1.doc" в поле "user_documents_attributes_0_item"
#     И я прикреплю файл "arh.rar" в поле "user_documents_attributes_1_item"
#     И я прикреплю файл "referati.zip" в поле "user_documents_attributes_2_item"
#     И я нажму "Загрузить"
#     И мы запустим процесс обработки всех файлов
#     Тогда я увижу "Обрабатываются файлы: 1.doc; arh.rar; referati.zip"
#     И я увижу "После обработки они появятся в списке ваших файлов"
#     Тогда я перейду по ссылке "Добавить ВУЗ"
#     И я увижу "Выберите ВУЗ"
#     И я не увижу "Новосибирский государственный университет"
#     Тогда я заполню поле "univer_modal_search_form" значением "Новосибирский государственный университет"
#     И я отправлю "univer_modal_search_form"
#     #ui steps here
#     И я не увижу "Новосибирский государственный университет"
#     И я перейду по ссылке "Добавить"
#     # ОШИБКА ЗДЕСЬ!
#     Тогда я увижу "Добавить ВУЗ"
#     И я заполню поле "Аббревиатура" значением "НГУ"
#     И я заполню поле "Название" значением "Новосибирский государственный университет"
#     И я заполню поле "Город" значением "Новосибирск"
#     И я прикреплю файл "NGU.gif" в поле "logo"
#     И я жду ajax
#     И я нажму "Создать"
#     Тогда я увижу "Новосибирский государственный университет"
#     И сфинкс индексируйся!
#     И я увижу "Добавить предмет"
#     И я перейду по ссылке "Добавить предмет"
#     И я жду ajax
#     И я увижу "Выберите предмет"
#     И я не увижу "Математический анализ"
#     Тогда я заполню поле "subject_modal_search_form" значением "Математический анализ"
#     И я отправлю "subject_modal_search_form"
#     И я не увижу "Математический анализ"
#     И я перейду по ссылке "Добавить"
#     Тогда я увижу "Добавить предмет"
#     И я увижу "Добавить предмет"
#     И я увижу "Аббревиатура"
#     И я увижу "Полное название"
#     И я увижу "Раздел"
#     И я заполню поле "Аббревиатура" значением "МанАн"
#     И я заполню поле "Полное название" значением "Математический анализ"
#     И я выберу значение "Математика" в списке "Раздел"
#     И я нажму "Создать"
#     Тогда я увижу "Математический анализ"


#Дополнения:
# Я решил отойти от pdf немного.
# Если у файла или папки есть описание, то оно тоже выводится, но видно только первую строку.
# В конце этой строки стоит ссылка с анкором "..." (троеточие). При клике на это троеточие или само описание,
# описание разворачивается полностью. При клике на развернутое описание, оно сворачивается.
# Пример свернутого описания на стр 22 папка "Новая папка"
# Пример развернутого описания на стр 22 файл "Понятие рекурсии и рекурсивные алгоритмы..."

# В pdf я сделал, что длинные имена файлов скрываются до одной строки. Думаю, это не очень удобно.
# Пусть имена выводятся полностью, даже если занимают несколько строк, и только описания сокращаются до одной строки.
# Но при редактировании должно быть ограничение на длину названия, чтобы небыло слишком длинных.

