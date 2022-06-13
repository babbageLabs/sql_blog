CREATE TYPE users.USER_LOGIN_TT AS
(
    email    core.email,
    username VARCHAR,
    password TEXT
)