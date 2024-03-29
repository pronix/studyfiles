# language: ru
Функционал:
  Просмотр страницы "пользователи" и отдельного пользователя

  Предыстория:
    Допустим в системе существует пользователь с логином и паролем "user@example.com/secret"
    И пользователь "user@example.com" имеет имя "Супер пользователь"

@green
  Сценарий: Отображение пользователей по рейтингу
    Допустим в системе есть пользователи:
      | email             | name            | rating | rank |
      | user2@example.com | Иван Палыч      |    100 |    1 |
      | user3@example.com | Петр Николаевич |     50 |    2 |
      | user4@example.com | Максим Иванович |     20 |    3 |
    И сфинкс индексируйся!
    И я на странице пользователей
    И я не должен видеть "Супер пользователь"
    И пользователь "user2@example.com" должен быть первым в юзер листе

@green
  Сценарий: Поиск по имени пользователя
   Допустим в системе есть пользователи:
      | email             | name            | rating | rank |
      | user2@example.com | Иван Палыч      |    100 |    1 |
      | user3@example.com | Петр Николаевич |     50 |    2 |
      | user4@example.com | Максим Иванович |     20 |    3 |
    И сфинкс индексируйся!
    И я на странице пользователей
    И я введу "иван палыч" в поле "search"
    И нажму "Найти"
    И я должен быть на странице пользователей
    И я должен увидеть "Иван Палыч"
    И я не должен видеть "Петр Николаевчи"
    И я не должен видеть "Максим Иванович"
    И я введу "макс" в поле "search"
    И нажму "Найти"
    И я должен увидеть "Максим Иванович"
    И я не должен видеть "Петр Николаевчи"
