# language: ru
Функционал: Загрузка документов с сайти и статистика по ним

  Предыстория:
    Допустим в системе существует пользователь с логином и паролем "user@example.com/secret"

@green
  Сценарий: Просмотр того кто сколько скачал
    И в системе есть файл "бытие.doc" с размером 218624
    И в системе есть файл "NGU.gif" с размером 4855
    И пользователь скачал файл "бытие.doc"
    И пользователь скачал файл "NGU.gif"
    И пользователь должен иметь у себя в скаченном файл "бытие.doc"
    И пользователь должен иметь у себя в скаченном файл "NGU.gif"
    И я иду на пользовательскую страницу "user@example.com"
    И я должен увидеть "2 файла на 218.2 КБ"

@green
 Сценарий: Загрузка целой папки
    Допустим есть следующие папки принадлежащии универу "МГУ":
      | name      |
      | Папка 1   |
      | Папка 1-1 |
    И папка "Папка 1-1" пренадлежит папке "Папка 1"
    И в системе есть файл "бытие.doc" с размером 218624
    И в системе есть файл "NGU.gif" с размером 4855
    И документа "бытие.doc" принадлежит папке "Папка 1"
    И документа "NGU.gif" принадлежит папке "Папка 1-1"
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я перейду на университетскую страницу "МГУ"
    И я перейду по ссылке "Скачать Папка 1"
    Тогда получу файл с именем "Папка 1.zip"
    И я иду на пользовательскую страницу "user@example.com"
    И я должен увидеть "2 файла на 218.2 КБ"