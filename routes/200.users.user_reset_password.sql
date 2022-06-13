CREATE OR REPLACE PROCEDURE users.reset_password(
    IN identifier VARCHAR(100) = NULL,
    IN meta core.META_TT = NULL
) AS
$$
DECLARE
    email_or_username VARCHAR(100) = identifier;
    actor             BIGINT       = meta.actor_id;
BEGIN
    IF identifier IS NULL THEN
        SELECT username
        INTO email_or_username
        FROM users."user" u
        WHERE actorid = meta.actor_id;
    END IF;

    IF email_or_username IS NULL THEN
        RAISE EXCEPTION 'Invalid username or email'
            USING HINT = 'invalid credentials';
    END IF;

    IF (SELECT "users".check_can_reset_password(NULL, email_or_username)) = TRUE THEN
        RAISE EXCEPTION 'You are not permitted to reset your password'
            USING HINT = 'user is in an invalid state';
    END IF;

    IF meta IS NULL THEN
        SELECT actorid
        INTO actor
        FROM users."user" u
        WHERE u.username = email_or_username
           OR u.email = email_or_username;
    END IF;

    IF actor IS NULL THEN
        RAISE EXCEPTION 'Invalid username or email'
            USING HINT = 'invalid credentials';
    END IF;


    INSERT INTO users.credentials_reset (actor_id, created_on, updated_by, updated_on, expires, status)
    VALUES (actor, CURRENT_TIMESTAMP, NULL, NULL, CURRENT_TIMESTAMP + INTERVAL '30m', 'pending');


END
$$ LANGUAGE plpgsql;