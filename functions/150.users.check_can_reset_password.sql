CREATE OR REPLACE FUNCTION users.check_can_reset_password(
    reset_key UUID = NULL, -- unique code showing status of password reset code
    identifier VARCHAR(50) = NULL -- username or email,
) RETURNS BOOLEAN AS
$$
BEGIN
    IF reset_key IS NOT NULL THEN
        IF EXISTS(SELECT 1
                  FROM users.credentials_reset s
                           JOIN users."user" u ON u.actorid = s.actor_id
                  WHERE status = 'pending'
                    AND created_on <= s.expires
                    AND s.id = reset_key) THEN
            RETURN TRUE;
        END IF;
    END IF;

    IF identifier IS NOT NULL THEN
        IF EXISTS(SELECT 1
                  FROM users."user"
                  WHERE is_enabled = FALSE AND (username = identifier OR email = identifier)) THEN
            RETURN FALSE;
        END IF;
    END IF;

    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;