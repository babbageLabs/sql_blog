CREATE TABLE IF NOT EXISTS acl.roles
(
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    is_enabled  BOOLEAN DEFAULT TRUE, -- is this role active
    created_on  TIMESTAMP    NOT NULL,

    CONSTRAINT uk_role_name UNIQUE (name)
)