CREATE TABLE IF NOT EXISTS acl.role_permissions
(
    id         BIGSERIAL PRIMARY KEY,
    role       BIGINT    NOT NULL,
    permission BIGINT    NOT NULL,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uk_role_permission UNIQUE (role, permission),
    CONSTRAINT fk_role_permissions_role FOREIGN KEY (role) REFERENCES acl.roles (id),
    CONSTRAINT fk_role_permissions_permission FOREIGN KEY (permission) REFERENCES acl.permissions (id)
)