CREATE OR REPLACE FUNCTION users.change_password(
    IN user_email VARCHAR(50),
    IN new_password TEXT,
    IN old_password TEXT = NULL,
    IN reset_key VARCHAR(100) = NULL,
    OUT is_password_reset BOOLEAN
) AS
$$
DECLARE
    can_reset_password BOOLEAN;
BEGIN
    IF reset_key IS NOT NULL OR old_password IS NOT NULL THEN
        SELECT users.check_can_reset_password(reset_key, user_email) INTO can_reset_password;

        RAISE NOTICE 'can reset password %', can_reset_password;

        IF can_reset_password IS TRUE AND old_password IS NOT NULL THEN
            UPDATE users."user" u
            SET password = crypt(new_password, gen_salt('bf'))
            WHERE u.email = user_email
              AND password = crypt(old_password, u.password)
            RETURNING TRUE INTO is_password_reset;
        ELSE
            RAISE EXCEPTION 'password reset failed' USING HINT = 'invalid password or reset key';
        END IF;
    ELSE
        RAISE EXCEPTION 'operation not permitted. provide the previous password or reset your password'
            USING HINT = 'unauthorized operation';
    END IF;
END;
$$ LANGUAGE plpgsql;