CREATE TABLE IF NOT EXISTS users.sessions
(
    id         UUID    DEFAULT uuid_generate_v4(),
    actor_id   BIGINT    NOT NULL,
    created_on TIMESTAMP NOT NULL,
    expires    TIMESTAMP NOT NULL,
    is_revoked BOOLEAN DEFAULT FALSE,
    revoked_by BIGINT    NULL,
    revoked_on TIMESTAMP    NULL,
    channel    core.CHANNELS,

    CONSTRAINT fksessionactorid FOREIGN KEY (actor_id) REFERENCES core.actor (id),
    CONSTRAINT fksessionrevokedby FOREIGN KEY (revoked_by) REFERENCES core.actor (id)
);

-- DROP TABLE IF EXISTS users.sessions;
