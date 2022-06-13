CREATE TABLE IF NOT EXISTS acl.permissions
(
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    is_enabled  BOOLEAN DEFAULT TRUE, -- is this action permitted
    created_on  TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uk_permission_name UNIQUE (name)
);