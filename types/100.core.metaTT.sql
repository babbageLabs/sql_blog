CREATE TYPE core.META_TT AS
(
    actor_id     BIGINT,
    ip_address   VARCHAR(50),
    channel      core.REQUIRED_CHANNEL,
    session_id   UUID,
    machine_name VARCHAR(50),
    host_name    VARCHAR(50),
    os           VARCHAR(50)
);

-- DROP TYPE IF EXISTS core.meta_tt CASCADE;