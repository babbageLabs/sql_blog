CREATE OR REPLACE PROCEDURE users.user_logout(
    meta IN core.meta_tt,
    session_id OUT UUID
) AS
$$
BEGIN

    -- handle authentication
    SELECT * FROM users.destroy_session(meta := meta, session_id := session_id);
END
$$ LANGUAGE plpgsql;