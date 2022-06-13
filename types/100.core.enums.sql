DO
$$
    BEGIN
        CREATE TYPE core.CHANNELS AS ENUM ('web' , 'mobile');
    EXCEPTION
        WHEN duplicate_object THEN NULL;
    END
$$;

DO
$$
    BEGIN
        CREATE TYPE core.ACTOR_TYPE AS ENUM ('user');
    EXCEPTION
        WHEN duplicate_object THEN NULL;
    END
$$;

DO
$$
    BEGIN
        CREATE TYPE users.RESET_STATUS AS ENUM ('pending', 'expired', 'invalidated' );
    EXCEPTION
        WHEN duplicate_object THEN NULL;
    END
$$;