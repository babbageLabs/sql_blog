DO
$$
    BEGIN
        CREATE TYPE acl.PERMISSION_TT AS
        (
            name core.REQUIRED_VARCHAR,
            description TEXT
        );
    EXCEPTION
        WHEN duplicate_object THEN NULL;
    END
$$;