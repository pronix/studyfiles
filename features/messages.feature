# language: ru
Функционал:  Отправка и получение личных сообщений

  Предыстория:
    Допустим в системе существует пользователь с логином и паролем и именем "ivan@example.com/secret/Иван_Иванович"
    Допустим в системе существует пользователь с логином и паролем "user@example.com/secret"

@green
  Сценарий:
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я на главной странице
    Когда я перейду по ссылке "Пользователи"
    И я перейду по ссылке "Иван_Иванович"
    И я перейду по ссылке "Написать в личку"
    Тогда я увижу "Сообщение пользователю Иван_Иванович"
    Когда я введу в поле "discussion[messages_attributes][0][body]" значение "Привет! А нет шпор по мат. анализу?"
    И я нажму "Отправить"
    Тогда я увижу "Привет! А нет шпор по мат. анализу?"
    Когда мне ответил пользователь "Иван_Иванович" текстом "Привет! К сожалению, пока не завезли."
    И я перейду по ссылке "Личные сообщения"
    Тогда я увижу "Иван_Иванович"
    И я увижу "1 сообщение"
    Когда я перейду по ссылке "Иван_Иванович"
    Тогда я увижу "Привет! К сожалению, пока не завезли."

@green
  Сценарий: Просмотр новых сообщений на главной. Если их 0
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я на главной странице
    И я должен увидеть "0 Сообщений"

@current
  Сценарий: Просмотр новых сообщений на главной. Если их больше 0
    Допустим пользователю "user@example.com" написали 3 сообщения
    Допустим я авторизован как пользователь с логином и паролем "user@example.com/secret"
    И я на главной странице
    И покажи страницу
    И я должен увидеть "3 Сообщения"
