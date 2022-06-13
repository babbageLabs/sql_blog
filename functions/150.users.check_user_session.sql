CREATE OR REPLACE FUNCTION users.check_user_session(
    IN meta core.META_TT,
    OUT session_id UUID
) AS
$$
BEGIN
    SELECT id
    FROM users.sessions s
    WHERE actor_id = meta.actor_id
      AND is_revoked = FALSE
      AND CURRENT_TIMESTAMP < s.expires
    INTO session_id;
END;
$$ LANGUAGE plpgsql;