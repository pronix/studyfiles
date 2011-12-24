# language: ru
Функционал:
  Просмотр страницы "пользователи" и отдельного пользователя

  Предыстория:
    Допустим в системе существует пользователь с логином и паролем "user@example.com/secret"
    И пользователь "user@example.com" имеет имя "Супер пользователь"
    Допустим в системе есть пользователи:
      | email             | name            |
      | user2@example.com | Иван Палыч      |
      | user3@example.com | Петр Николаевич |
    Допустим в системе есть следующие вузы:
      | name           | abbreviation |
      | Хороший универ | ХУ           |
      | Плохой универ  | ПУ           |
    Допустим в универе "ХУ" есть следующие предметы:
      | name         |
      | Математика   |
      | Русский язык |
    Допустим у пользователя "user@example.com" в вузе "ХУ" есть документы:
      | name       |
      | Документ пользователя 1 |
      | Документ пользователя 2 |
    И за документ "Документ пользователя 1" проголосовали 10 раз
    И за документ "Документ пользователя 2" проголосовали 10 раз
    И пользователь "user@example.com" из универа "ХУ"
    И пользователь "user2@example.com" из универа "ПУ"
    И пользователь "user3@example.com" из универа "ПУ"
    И я обновлю райтинг для вуза "ХУ"

@green @wip
  Сценарий: хз
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret" 
    Тогда я перейду по ссылке "Пользователи"
    И я должен увидеть "Рейтинг: 20"
    И я должен увидеть "Иван Палыч"
    И я должен увидеть "Петр Николаевич"
    И я должен увидеть "ПУ"
    И я должен увидеть "ХУ"
    И я должен увидеть "20"
    И я должен увидеть "Файлов 2"
    И я должен увидеть "Супер пользователь"
    Тогда я перейду по ссылке "Супер пользователь"
    И я должен увидеть "Хороший универ"
# @current
#   Сценарий: Отображение пользователей по рейтингу
#     И я на странице пользователей
#     И покажи страницу
