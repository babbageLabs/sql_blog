CREATE DOMAIN required_varchar AS
    VARCHAR NOT NULL CHECK (value IS NOT NULL);

CREATE DOMAIN required_bigint AS
    BIGINT NOT NULL;

CREATE DOMAIN required_text AS
    TEXT NOT NULL;

CREATE DOMAIN email AS VARCHAR CHECK ( VALUE ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$');

CREATE DOMAIN required_email AS email NOT NULL;

CREATE DOMAIN required_channel AS core.channels NOT NULL;