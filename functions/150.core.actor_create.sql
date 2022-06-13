CREATE OR REPLACE FUNCTION core.actor_create(
    actor_type core.ACTOR_TYPE,
    meta core.META_TT,
    actor_id OUT BIGINT
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO core.actor(type, created_on, created_by)
    VALUES (actor_type, NOW(), meta.actor_id)
    RETURNING id INTO actor_id;
END;
$$

