CREATE OR REPLACE FUNCTION users.get_create_session(
    IN meta core.META_TT,
    IN force BOOLEAN,
    OUT session_id UUID
) AS
$$
BEGIN
    SELECT check_user_session FROM users.check_user_session(meta) INTO session_id;

    IF force IS FALSE AND session_id IS NOT NULL THEN
        RETURN;
    END IF;

    INSERT INTO users.sessions(actor_id, created_on, expires, is_revoked, revoked_by, channel)
    VALUES (meta.actor_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '3h', FALSE, NULL,
            meta.channel)
    RETURNING id INTO session_id;
END;
$$ LANGUAGE plpgsql;