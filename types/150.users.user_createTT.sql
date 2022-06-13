CREATE TYPE users.USER_CREATE_TT AS
(
    email    core.REQUIRED_VARCHAR,
    username core.REQUIRED_VARCHAR,
    password core.REQUIRED_TEXT
)