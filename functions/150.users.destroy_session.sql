CREATE OR REPLACE FUNCTION users.destroy_session(
    IN meta core.META_TT,
    INOUT session_id UUID = NULL
) AS
$$
BEGIN
    UPDATE users.sessions s
    SET is_revoked = TRUE,
        revoked_by = meta.actor_id,
        revoked_on = CURRENT_TIMESTAMP
    WHERE s.id = meta.session_id
      AND s.is_revoked = FALSE
    RETURNING s.id INTO session_id;
END;
$$ LANGUAGE plpgsql;