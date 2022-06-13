CREATE TABLE IF NOT EXISTS core.actor (
    id BIGSERIAL PRIMARY KEY,
    type actor_type,
    created_on TIMESTAMP NOT NULL,
    created_by BIGINT
);