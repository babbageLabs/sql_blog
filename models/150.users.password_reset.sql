CREATE TABLE IF NOT EXISTS users.credentials_reset
(
    id         UUID DEFAULT uuid_generate_v4(),
    actor_id   BIGINT    NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_by BIGINT,
    updated_on TIMESTAMP,
    expires    TIMESTAMP,
    status     users.RESET_STATUS,

    CONSTRAINT fk_actor_reset_password FOREIGN KEY (actor_id) REFERENCES core.actor (id)
)