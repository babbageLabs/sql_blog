CREATE TABLE IF NOT EXISTS users.user (
    actorId BIGINT NOT NULL PRIMARY KEY,
    email VARCHAR(50),
    username VARCHAR(50),
    password TEXT,
    is_enabled BOOLEAN DEFAULT TRUE,

    CONSTRAINT fkUserActorId FOREIGN KEY (actorId) REFERENCES core.actor(id),
    CONSTRAINT ukUserEmail UNIQUE (email),
    CONSTRAINT ukUserName UNIQUE (username)
);