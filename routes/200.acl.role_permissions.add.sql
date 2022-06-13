CREATE OR REPLACE PROCEDURE acl.role_permissions_add(
    IN permission_id BIGINT,
    IN role_id BIGINT,
    IN meta core.META_TT
) AS
$$
BEGIN
    INSERT INTO acl.role_permissions (role, permission, created_on)
    VALUES (role_id, permission_id, CURRENT_TIMESTAMP);
END;
$$ LANGUAGE plpgsql;