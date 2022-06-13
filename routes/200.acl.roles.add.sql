CREATE OR REPLACE PROCEDURE acl.roles_add(
    IN roles acl.ROLE_TT[],
    IN meta core.META_TT
) AS
$$
BEGIN
    INSERT INTO acl.roles (name, description)
    SELECT *
    FROM UNNEST(roles) a;
END;
$$ LANGUAGE plpgsql;