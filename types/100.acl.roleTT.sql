DO
$$
    BEGIN
        CREATE TYPE acl.ROLE_TT AS
        (
            name core.REQUIRED_VARCHAR,
            description TEXT
        );
    EXCEPTION
        WHEN duplicate_object THEN NULL;
    END
$$;