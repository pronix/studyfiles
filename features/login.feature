# language: ru

Функционал: Авторизация и регистрация пользователя

  Предыстория:
    Допустим в системе существует пользователь с логином и паролем "user@example.com/secret"
    Допустим я на главной странице

  @green
  Сценарий:
    Если я перейду по ссылке "Войти"
    Тогда увижу "Войти"
    Если я введу в поле "exist_user_email" значение "user@example.com"
    И я введу в поле "exist_user_password" значение "secret"
    И я нажму "Войти"
    Тогда увижу "Выйти"

  @green
  Сценарий:
    Если я перейду по ссылке "Зарегистрироваться"
    Тогда увижу "Завести новый аккаунт"
    И увижу "Войти"
    Если я введу в поле "new_user_email" значение "user1@example.com"
    И я введу в поле "new_user_password" значение "secret"
    И я введу в поле "user_password_confirmation" значение "secret"
    И нажму "Завести аккаунт"
    Тогда увижу "Выйти"
