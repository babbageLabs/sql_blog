CREATE OR REPLACE PROCEDURE users.user_login(
    "user" users.USER_LOGIN_TT,
    meta INOUT core.META_TT
) AS
$$
DECLARE
    identifier VARCHAR(50);
    user_id    BIGINT;
    session_id UUID;
BEGIN
    SELECT COALESCE("user".username, "user".email) INTO identifier;


    -- handle authentication
    SELECT u.actorid
    FROM users."user" u
    WHERE ("user".username = u.username OR "user".email = u.email)
      AND u.password = crypt("user".password, u.password)
    INTO user_id;

    IF NOT found THEN
        RAISE EXCEPTION 'The user % could not be authenticated',
            identifier
            USING HINT = 'invalid credentials';
    ELSE
        meta.actor_id := user_id;
--         actor_id := (SELECT core.actor_create('user', meta := meta));
        SELECT users.get_create_session(meta := meta, force := FALSE) INTO session_id;
        meta.session_id := session_id;


    END IF;
END
$$ LANGUAGE plpgsql;