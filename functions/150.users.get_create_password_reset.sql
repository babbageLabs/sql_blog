CREATE OR REPLACE FUNCTION users.get_create_password_reset(
    IN meta core.META_TT,
    IN force BOOLEAN,
    OUT reset_id UUID
) AS
$$
BEGIN
    IF force IS NOT TRUE THEN
        SELECT s.id
        FROM users.credentials_reset s
        WHERE actor_id = meta.actor_id
          AND status = 'pending'
          AND created_on <= s.expires
        INTO reset_id;

        IF reset_id IS NOT NULL THEN
            RETURN;
        END IF;
    END IF;

    INSERT INTO users.credentials_reset(actor_id, created_on, updated_by, updated_on, expires, status)
    VALUES (meta.actor_id, CURRENT_TIMESTAMP, NULL, NULL, CURRENT_TIMESTAMP + INTERVAL '6h', 'pending')
    RETURNING id INTO reset_id;
END;
$$ LANGUAGE plpgsql;