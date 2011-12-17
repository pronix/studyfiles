# language: ru
Функционал: Предметы
  Предыстория:
    Допустим в университете "МГУ" есть следующие предметы:
    | name         |
    | Математика   |
    | Русский язык |
    Допустим предмет в универе "МГУ" "Математика" имеет следующие папки:
    | name     |
    | Дипломы  |
    | Курсовые |
    Допустим в университете "ВШЭ" есть следующие предметы:
    | name       |
    | Математика |
    Допустим предмет в универе "ВШЭ" "Математика" имеет следующие папки:
    | name   |
    | Работы |
  
@green
  Сценарий: Переход на страницу предмета
    Допустим я на главной странице
    И я должен увидеть "Математика"
    И я должен увидеть "Русский язык"
    И я перейду по ссылке "Математика"
    И я должен увидеть "Математика"
    И я должен увидеть "Дипломы"
    И я должен увидеть "Курсовые"
    Но я не должен увидеть "Работы"
