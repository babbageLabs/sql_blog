CREATE OR REPLACE FUNCTION users.validate_session(
    IN meta core.META_TT,
    OUT is_valid BOOLEAN
) AS
$$
DECLARE
    valid_session_id UUID = NULL;
BEGIN
    SELECT id
    FROM users.sessions s
    WHERE s.id = meta.session_id
      AND is_revoked IS FALSE
      AND s.actor_id = meta.actor_id
    INTO valid_session_id;

    IF valid_session_id IS NULL THEN
        RAISE EXCEPTION 'invalid session state'
            USING HINT = 'invalid session';
    END IF;
    SELECT TRUE INTO is_valid;
END;
$$ LANGUAGE plpgsql;