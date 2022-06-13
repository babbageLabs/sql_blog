CREATE OR REPLACE PROCEDURE users.user_create(
    body users.USER_CREATE_TT, -- username
    meta core.META_TT, -- meta data
    actor OUT BIGINT
) AS
$$
DECLARE
    actor_id BIGINT;
BEGIN
    actor_id := (SELECT core.actor_create('user', meta := meta));

    INSERT INTO users.user(actorid, email, username, password)
    VALUES (actor_id,
            body.email,
            body.username,
            crypt(body.password, gen_salt('bf')))
    RETURNING actorid INTO actor;
END
$$ LANGUAGE plpgsql;