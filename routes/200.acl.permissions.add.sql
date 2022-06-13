CREATE OR REPLACE PROCEDURE acl.permissions_add(
    IN permissions acl.PERMISSION_TT[],
    IN meta core.META_TT
) AS
$$
BEGIN
    INSERT INTO acl.permissions (name, description)
    SELECT *
    FROM UNNEST(permissions) a;
END;
$$ LANGUAGE plpgsql;